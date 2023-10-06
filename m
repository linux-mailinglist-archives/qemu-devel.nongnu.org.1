Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 019FB7BB3F0
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogn6-00083C-3k; Fri, 06 Oct 2023 05:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmv-00082J-ES
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:25 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1qogmr-0000tp-LB
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:06:24 -0400
Received: (qmail 19469 invoked by uid 484); 6 Oct 2023 09:06:19 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.071756 secs); 06 Oct 2023 09:06:19 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 6 Oct 2023 09:06:18 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian.Boenig@lauterbach.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicolas Eder <nicolas.eder@lauterbach.com>
Subject: [PATCH v2 06/29] query for registers added
Date: Fri,  6 Oct 2023 11:05:47 +0200
Message-Id: <20231006090610.26171-7-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: neder <nicolas.eder@lauterbach.com>

---
 mcdstub/internals.h    |  55 +++++--
 mcdstub/mcdstub.c      | 320 ++++++++++++++++++++++++++++++++++++++---
 target/arm/meson.build |   1 +
 3 files changed, 344 insertions(+), 32 deletions(-)

diff --git a/mcdstub/internals.h b/mcdstub/internals.h
index 8df535e92a..45ba1ca8cb 100644
--- a/mcdstub/internals.h
+++ b/mcdstub/internals.h
@@ -8,6 +8,8 @@
 
 #include "exec/cpu-common.h"
 #include "chardev/char.h"
+// just used for the register xml files
+#include "exec/gdbstub.h"       /* xml_builtin */
 
 #define MAX_PACKET_LENGTH 1024
 
@@ -19,6 +21,15 @@
 #define MCD_TRIG_OPT_DATA_IS_CONDITION 0x00000008
 #define MCD_TRIG_ACTION_DBG_DEBUG 0x00000001
 
+// GDB stuff thats needed for GDB function, which we use
+typedef struct GDBRegisterState {
+    int base_reg;
+    int num_regs;
+    gdb_get_reg_cb get_reg;
+    gdb_set_reg_cb set_reg;
+    const char *xml;
+    struct GDBRegisterState *next;
+} GDBRegisterState;
 
 /*
  * struct for an MCD Process, each process can establish one connection
@@ -75,10 +86,6 @@ enum RSState {
     RS_IDLE,
     RS_GETLINE,
     RS_DATAEND,
-    //RS_GETLINE_ESC,
-    //RS_GETLINE_RLE,
-    //RS_CHKSUM1,
-    //RS_CHKSUM2,
 };
 
 typedef struct MCDState {
@@ -103,6 +110,7 @@ typedef struct MCDState {
 
     // my stuff
     GArray *reggroups;
+    GArray *registers;
 } MCDState;
 
 /* lives in main mcdstub.c */
@@ -110,9 +118,34 @@ extern MCDState mcdserver_state;
 
 typedef struct mcd_reg_group_st {
     const char *name;
-    const char *id;
+    uint32_t id;
 } mcd_reg_group_st;
 
+typedef struct xml_attrib {
+    char argument[64];
+    char value[64];
+} xml_attrib;
+
+typedef struct mcd_reg_st {
+    // xml info
+    char name[64];
+    char group[64];
+    char type[64];
+    uint32_t bitsize;
+    uint32_t id;
+    // mcd metadata
+    uint32_t mcd_reg_group_id;
+    uint32_t mcd_mem_space_id;
+    uint32_t mcd_reg_type;
+    uint32_t mcd_hw_thread_id;
+    // data for op-code
+    uint8_t cp;
+    uint8_t crn;
+    uint8_t crm;
+    uint8_t opc0; // <- might not be needed!
+    uint8_t opc1;
+    uint8_t opc2;
+} mcd_reg_st;
 
 // Inline utility function, convert from int to hex and back
 
@@ -139,12 +172,6 @@ static inline int tohex(int v)
     }
 }
 
-
-/*old functions
-void mcd_init_mcdserver_state(void);
-int mcd_open_tcp_socket(int tcp_port);
-int mcd_extract_tcp_port_num(const char *in_string, char *out_string);
-*/
 #ifndef _WIN32
 void mcd_sigterm_handler(int signal);
 #endif
@@ -194,10 +221,16 @@ void mcd_continue(void);
 void handle_query_mem_spaces(GArray *params, void *user_ctx);
 void handle_query_reg_groups_f(GArray *params, void *user_ctx);
 void handle_query_reg_groups_c(GArray *params, void *user_ctx);
+void handle_query_regs_f(GArray *params, void *user_ctx);
+void handle_query_regs_c(GArray *params, void *user_ctx);
 void handle_init(GArray *params, void *user_ctx);
+void parse_reg_xml(const char *xml, int size);
 
 /* sycall handling */
 void mcd_syscall_reset(void);
 void mcd_disable_syscalls(void);
 
+// helpers
+int int_cmp(gconstpointer a, gconstpointer b);
+
 #endif /* MCDSTUB_INTERNALS_H */
diff --git a/mcdstub/mcdstub.c b/mcdstub/mcdstub.c
index 9817f0893c..81026a42a1 100644
--- a/mcdstub/mcdstub.c
+++ b/mcdstub/mcdstub.c
@@ -8,7 +8,6 @@
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
-//#include "trace.h"
 #include "exec/mcdstub.h"
 #include "mcdstub/syscalls.h"
 #include "hw/cpu/cluster.h"
@@ -31,8 +30,10 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
 
-// just used for the xml_builtin stuff
-//#include "exec/gdbstub.h"       /* xml_builtin */
+//architecture specific stuff
+#include "target/arm/mcdstub.h"
+
+// FIXME: delete the following line and check if it worked
 #include "hw/core/sysemu-cpu-ops.h"
 
 typedef struct {
@@ -75,6 +76,15 @@ static const MCDCmdParseEntry mcd_gen_query_table[] = {
         .cmd = "reggroupc",
         .schema = "i",
     },
+    {
+        .handler = handle_query_regs_f,
+        .cmd = "regf",
+    },
+    {
+        .handler = handle_query_regs_c,
+        .cmd = "regc",
+        .schema = "i",
+    },
 };
 
 void mcd_init_mcdserver_state(void)
@@ -494,21 +504,21 @@ void run_cmd_parser(const char *data, const MCDCmdParseEntry *cmd)
     }
 }
 
-int cmd_parse_params(const char *data, const char *schema, GArray *params)
-{
+int cmd_parse_params(const char *data, const char *schema, GArray *params) {
     MCDCmdVariant this_param;
 
+    char data_buffer[64] = {0};
     if (schema[0] == 's') {
         this_param.data = data;
         g_array_append_val(params, this_param);
     }
     else if (schema[0] == 'i') {
-        this_param.index_handle = atoi(data);
-    g_array_append_val(params, this_param);
+        strncat(data_buffer, data, strlen(data));
+        this_param.index_handle = atoi(data_buffer);
+        g_array_append_val(params, this_param);
     }
 
     return 0;
-    
 }
 
 int process_string_cmd(void *user_ctx, const char *data, const MCDCmdParseEntry *cmds, int num_cmds)
@@ -885,23 +895,248 @@ CPUState *find_cpu(uint32_t thread_id)
     return NULL;
 }
 
+
+void parse_reg_xml(const char *xml, int size) {
+    // iterates over the complete xml file
+    int i, j;
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
+        if (still_to_skip>0) {
+            // skip chars unwanted chars
+            still_to_skip --;
+            continue;
+        }
+
+        if (strncmp(&xml[i], "<reg", 4)==0) {
+            // start of a register
+            still_to_skip = 3;
+            is_reg = true;
+            reg_data = g_array_new(false, true, sizeof(xml_attrib));
+        }
+        else if (is_reg) {
+            if (strncmp(&xml[i], "/>", 2)==0) {
+                // end of register info
+                still_to_skip = 1;
+                is_reg = false;
+
+                // create empty register
+                mcd_reg_st my_register = (const struct mcd_reg_st){ 0 };
+
+                // add found attribtues
+                for (j = 0; j<reg_data->len; j++) {
+                    attribute_j = g_array_index(reg_data, xml_attrib, j);
+
+                    argument_j = attribute_j.argument;
+                    value_j = attribute_j.value;
+
+                    if (strcmp(argument_j, "name")==0) {
+                        strcpy(my_register.name, value_j);
+                    }
+                    else if (strcmp(argument_j, "regnum")==0) {
+                        my_register.id = atoi(value_j);
+                    }
+                    else if (strcmp(argument_j, "bitsize")==0) {
+                        my_register.bitsize = atoi(value_j);
+                    }
+                    else if (strcmp(argument_j, "type")==0) {
+                        strcpy(my_register.type, value_j);
+                    }
+                    else if (strcmp(argument_j, "group")==0) {
+                        strcpy(my_register.group, value_j);
+                    }
+                }
+                // store register
+                g_array_append_vals(mcdserver_state.registers, (gconstpointer)&my_register, 1);
+                // free memory
+                g_array_free(reg_data, false);
+            }
+            else {
+                // store info for register
+                switch (c) {
+                    case ' ':
+                        break;
+                    case '=':
+                        is_argument = false;
+                        break;
+                    case '"':
+                        if (is_value) {
+                            // end of value reached
+                            is_value = false;
+                            // store arg-val combo
+                            xml_attrib current_attribute;
+                            strcpy(current_attribute.argument, argument);
+                            strcpy(current_attribute.value, value);
+                            g_array_append_vals(reg_data, (gconstpointer)&current_attribute, 1);
+                            memset(argument, 0, sizeof(argument));
+                            memset(value, 0, sizeof(value));
+                        }
+                        else {
+                            //start of value
+                            is_value = true;
+                        }
+                        break;
+                    default:
+                        if (is_argument) {
+                            strncat(argument, c_ptr, 1);
+                        }
+                        else if (is_value) {
+                            strncat(value, c_ptr, 1);
+                        }
+                        else {
+                            is_argument = true;
+                            strncat(argument, c_ptr, 1);
+                        }
+                        break;
+                }
+            }
+        }
+    }
+}
+
+int int_cmp(gconstpointer a, gconstpointer b) {
+    int a_int = *(int*)a;
+    int b_int = *(int*)b;
+    if (a_int == b_int) {
+        return 0;
+    }
+    else {
+        return 1;
+    }
+}
+
 void handle_init(GArray *params, void *user_ctx) {
     CPUState *cpu = mcdserver_state.c_cpu;
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     gchar *arch = cc->gdb_arch_name(cpu);
 
-    // store reg groups
+    
     if (strcmp(arch, "arm")==0) {
+        // store reg groups
+        uint32_t current_group_id = 0;
+
         // at the moment we just assume there are 3 spaces (gpr, per and debug)
         // TODO: this might cause a memory leak when called a second time -> maybe free the Garray first
         mcdserver_state.reggroups = g_array_new(false, true, sizeof(mcd_reg_group_st));
 
-        mcd_reg_group_st group1 = { .name = "GPR Registers", .id = "1" };
+        // store the registers themselves
+        mcdserver_state.registers = g_array_new(false, true, sizeof(mcd_reg_st));
+        GList *register_numbers = NULL;
+
+        const char *xml_filename = NULL;
+        const char *xml_content = NULL;
+        const char *name = NULL;
+        int i;
+
+        // 1. check out the core xml file
+        xml_filename = cc->gdb_core_xml_file;
+
+        for (i = 0; ; i++) {
+                name = xml_builtin[i][0];
+                if (!name || (strncmp(name, xml_filename, strlen(xml_filename)) == 0 && strlen(name) == strlen(xml_filename)))
+                break;
+            }
+        // without gpr registers we can do nothing
+        assert(name);
+        // add group for gpr registers
+        current_group_id = 1;
+        mcd_reg_group_st group1 = { .name = "GPR Registers", .id = current_group_id };
         g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&group1, 1);
 
-        mcd_reg_group_st group2 = { .name = "CP15 Registers", .id = "2" };
-        g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&group2, 1);
+        // parse xml
+        xml_content = xml_builtin[i][1];
+        parse_reg_xml(xml_content, strlen(xml_content));
+
+        // 2. iterate over all other xml files
+        GDBRegisterState *r;
+        for (r = cpu->gdb_regs; r; r = r->next) {
+            xml_filename = r->xml;
+            xml_content = NULL;
+
+            // first, check if this is a coprocessor xml
+
+            // funciton call
+            xml_content = arm_mcd_get_dynamic_xml(cpu, xml_filename);
+            if (xml_content) {
+                if (strcmp(xml_filename, "system-registers.xml")==0) {
+                    //these are the coprocessor register
+                    current_group_id = 2;
+                    mcd_reg_group_st group2 = { .name = "CP15 Registers", .id = current_group_id };
+                    g_array_append_vals(mcdserver_state.reggroups, (gconstpointer)&group2, 1);
+                }
+                
+            }
+            else {
+                // its not a coprocessor xml -> it is a static xml file
+                for (i = 0; ; i++) {
+                    name = xml_builtin[i][0];
+                    if (!name || (strncmp(name, xml_filename, strlen(xml_filename)) == 0 && strlen(name) == strlen(xml_filename)))
+                    break;
+                }
+                if (name) {
+                    xml_content = xml_builtin[i][1];
+                }
+                else {
+                    printf("no data found for %s\n", xml_filename);
+                    continue;
+                }
+            }
+
+            // parse xml
+            parse_reg_xml(xml_content, strlen(xml_content));
+        }
+        // go over the register array and collect all additional data
+        mcd_reg_st *current_register;
+        int id_neg_offset = 0;
+        int effective_id;
+        for (i = 0; i < mcdserver_state.registers->len; i++) {
+            current_register = &(g_array_index(mcdserver_state.registers, mcd_reg_st, i));
+            // ad an id handle
+            if (current_register->id) {
+                // id is already in place
+                //FIXME: we are missing 10 registers (likely the FPA regs or sth)
+                int used_id = current_register->id;
+                register_numbers = g_list_append(register_numbers, &used_id);
+                id_neg_offset ++;
+            }
+            else {
+                effective_id = i - id_neg_offset;
+                if (g_list_find_custom(register_numbers, &effective_id, (GCompareFunc)int_cmp)!=NULL) {
+                    id_neg_offset --;
+                }
+                current_register->id = i - id_neg_offset;
+            }
+            // sort into correct reg_group and according mem_space
+            if (strcmp(current_register->group, "cp_regs")==0) {
+                current_register->mcd_reg_group_id = 2;
+                current_register->mcd_mem_space_id = 6;
+                // get info for opcode
+            }
+            else {
+                // gpr register
+                current_register->mcd_reg_group_id = 1;
+                current_register->mcd_mem_space_id = 5;
+            }
+        }
+        // free memory
+        g_list_free(register_numbers);
     }
     else {
         // we don't support other architectures
@@ -910,7 +1145,7 @@ void handle_init(GArray *params, void *user_ctx) {
     g_free(arch);
 
     // the mcdserver is set up and we return the handshake
-    mcd_put_packet("shaking your hand");
+    mcd_put_packet("shaking your hand"); 
 }
 
 void handle_query_system(GArray *params, void *user_ctx) {
@@ -932,10 +1167,6 @@ void handle_query_cores(GArray *params, void *user_ctx) {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     gchar *arch = cc->gdb_arch_name(cpu);
     
-    //const char *cpu_name = object_get_canonical_path_component(OBJECT(cpu));
-    //int process_id = mcd_get_cpu_pid(cpu);
-    //int cpu_index = cpu->cpu_index;
-    //int cpu_cluster = cpu->cluster_index;
     int nr_cores = cpu->nr_cores;
 
     g_string_append_printf(mcdserver_state.str_buf, "device=\"qemu-%s-device\",core=\"%s\",nr_cores=\"%d\"", arch, cpu_model, nr_cores);
@@ -1039,13 +1270,21 @@ void handle_query_mem_spaces(GArray *params, void *user_ctx) {
 
 void handle_query_reg_groups_f(GArray *params, void *user_ctx) {
     // send the first reg group
+    int nb_groups = mcdserver_state.reggroups->len;
+    if (nb_groups == 1) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "1!");
+    }
     mcd_reg_group_st group = g_array_index(mcdserver_state.reggroups, mcd_reg_group_st, 0);
-    g_string_printf(mcdserver_state.str_buf, "1!id=%s.name=%s.", group.id, group.name);
+    g_string_append_printf(mcdserver_state.str_buf, "id=%d.name=%s.", group.id, group.name);
     mcd_put_strbuf();
 }
 
 void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
-    // this funcitons send all reg groups exept for the first
+    // this funcitons send all reg groups except for the first
     // 1. get parameter
     int query_index = get_param(params, 0)->index_handle;
 
@@ -1056,12 +1295,51 @@ void handle_query_reg_groups_c(GArray *params, void *user_ctx) {
         g_string_printf(mcdserver_state.str_buf, "0!");
     }
     else {
-        // provides
         g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
     }
 
     // 3. send the correct reggroup
     mcd_reg_group_st group = g_array_index(mcdserver_state.reggroups, mcd_reg_group_st, query_index);
-    g_string_append_printf(mcdserver_state.str_buf, "id=%s.name=%s.", group.id, group.name);
+    g_string_append_printf(mcdserver_state.str_buf, "id=%d.name=%s.", group.id, group.name);
+    mcd_put_strbuf();
+}
+
+void handle_query_regs_f(GArray *params, void *user_ctx) {
+    // send the first register
+    int nb_regs = mcdserver_state.registers->len;
+    if (nb_regs == 1) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "1!");
+    }
+    mcd_reg_st my_register = g_array_index(mcdserver_state.registers, mcd_reg_st, 0);
+    g_string_append_printf(mcdserver_state.str_buf, "id=%d.name=%s.size=%d.reggroupid=%d.memspaceid=%d.type=%d.thread=%d.",
+        my_register.id, my_register.name, my_register.bitsize, my_register.mcd_reg_group_id,
+        my_register.mcd_mem_space_id, my_register.mcd_reg_type, my_register.mcd_hw_thread_id);
+    mcd_put_strbuf();
+}
+
+void handle_query_regs_c(GArray *params, void *user_ctx) {
+    // this funcitons send all registers except for the first
+    // 1. get parameter
+    int query_index = get_param(params, 0)->index_handle;
+
+    // 2. check weather this was the last register
+    int nb_regs = mcdserver_state.registers->len;
+    if (query_index+1 == nb_regs) {
+        // indicates this is the last packet
+        g_string_printf(mcdserver_state.str_buf, "0!");
+    }
+    else {
+        g_string_printf(mcdserver_state.str_buf, "%d!", query_index+1);
+    }
+
+    // 3. send the correct register
+    mcd_reg_st my_register = g_array_index(mcdserver_state.registers, mcd_reg_st, query_index);
+    g_string_append_printf(mcdserver_state.str_buf, "id=%d.name=%s.size=%d.reggroupid=%d.memspaceid=%d.type=%d.thread=%d.",
+        my_register.id, my_register.name, my_register.bitsize, my_register.mcd_reg_group_id,
+        my_register.mcd_mem_space_id, my_register.mcd_reg_type, my_register.mcd_hw_thread_id);
     mcd_put_strbuf();
 }
diff --git a/target/arm/meson.build b/target/arm/meson.build
index e645e456da..71ff10316f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -3,6 +3,7 @@ arm_ss.add(files(
   'cpu.c',
   'debug_helper.c',
   'gdbstub.c',
+  'mcdstub.c',
   'helper.c',
   'vfp_helper.c',
 ))
-- 
2.34.1


