Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C67E3FC6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:10:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Lma-0001qM-98; Tue, 07 Nov 2023 08:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lko-0008KI-LT
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:28 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0Lkg-000602-DK
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:04:25 -0500
Received: (qmail 31271 invoked by uid 484); 7 Nov 2023 13:04:01 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.071439 secs); 07 Nov 2023 13:04:01 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:59 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 12/20] mcdstub: missing parse_reg_xml function for parsing
 gdb register xml files added
Date: Tue,  7 Nov 2023 14:03:15 +0100
Message-Id: <20231107130323.4126-13-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

---
 mcdstub/mcdstub.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index d71dff633a..3e87378b45 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -867,6 +867,127 @@ CPUState *find_cpu(uint32_t thread_id)
 }
 
 
+void parse_reg_xml(const char *xml, int size, GArray *registers,
+    uint8_t reg_type, uint32_t reg_id_offset)
+{
+    /* iterates over the complete xml file */
+    int i, j;
+    uint32_t current_reg_id = reg_id_offset;
+    uint32_t internal_id;
+    int still_to_skip = 0;
+    char argument[64] = {0};
+    char value[64] = {0};
+    bool is_reg = false;
+    bool is_argument = false;
+    bool is_value = false;
+    GArray *reg_data;
+
+    char c;
+    char *c_ptr;
+
+    xml_attrib attribute_j;
+    const char *argument_j;
+    const char *value_j;
+
+    for (i = 0; i < size; i++) {
+        c = xml[i];
+        c_ptr = &c;
+
+        if (still_to_skip > 0) {
+            /* skip unwanted chars */
+            still_to_skip--;
+            continue;
+        }
+
+        if (strncmp(&xml[i], "<reg", 4) == 0) {
+            /* start of a register */
+            still_to_skip = 3;
+            is_reg = true;
+            reg_data = g_array_new(false, true, sizeof(xml_attrib));
+        } else if (is_reg) {
+            if (strncmp(&xml[i], "/>", 2) == 0) {
+                /* end of register info */
+                still_to_skip = 1;
+                is_reg = false;
+
+                /* create empty register */
+                mcd_reg_st my_register = (const struct mcd_reg_st){ 0 };
+
+                /* add found attribtues */
+                for (j = 0; j < reg_data->len; j++) {
+                    attribute_j = g_array_index(reg_data, xml_attrib, j);
+
+                    argument_j = attribute_j.argument;
+                    value_j = attribute_j.value;
+
+                    if (strcmp(argument_j, "name") == 0) {
+                        strcpy(my_register.name, value_j);
+                    } else if (strcmp(argument_j, "regnum") == 0) {
+                        my_register.id = atoi(value_j);
+                    } else if (strcmp(argument_j, "bitsize") == 0) {
+                        my_register.bitsize = atoi(value_j);
+                    } else if (strcmp(argument_j, "type") == 0) {
+                        strcpy(my_register.type, value_j);
+                    } else if (strcmp(argument_j, "group") == 0) {
+                        strcpy(my_register.group, value_j);
+                    }
+                }
+                /* add reg_type, internal_id and id*/
+                my_register.reg_type = reg_type;
+                my_register.internal_id = internal_id;
+                internal_id++;
+                if (!my_register.id) {
+                    my_register.id = current_reg_id;
+                    current_reg_id++;
+                } else {
+                    /* set correct ID for the next register */
+                    current_reg_id = my_register.id + 1;
+                }
+                /* store register */
+                g_array_append_vals(registers, (gconstpointer)&my_register, 1);
+                /* free memory */
+                g_array_free(reg_data, false);
+            } else {
+                /* store info for register */
+                switch (c) {
+                case ' ':
+                    break;
+                case '=':
+                    is_argument = false;
+                    break;
+                case '"':
+                    if (is_value) {
+                        /* end of value reached */
+                        is_value = false;
+                        /* store arg-val combo */
+                        xml_attrib current_attribute;
+                        strcpy(current_attribute.argument, argument);
+                        strcpy(current_attribute.value, value);
+                        g_array_append_vals(reg_data,
+                        (gconstpointer)&current_attribute, 1);
+                        memset(argument, 0, sizeof(argument));
+                        memset(value, 0, sizeof(value));
+                    } else {
+                        /*start of value */
+                        is_value = true;
+                    }
+                    break;
+                default:
+                    if (is_argument) {
+                        strncat(argument, c_ptr, 1);
+                    } else if (is_value) {
+                        strncat(value, c_ptr, 1);
+                    } else {
+                        is_argument = true;
+                        strncat(argument, c_ptr, 1);
+                    }
+                    break;
+                }
+            }
+        }
+    }
+}
+
 int int_cmp(gconstpointer a, gconstpointer b)
 {
     int int_a = *(int *)a;
-- 
2.34.1


