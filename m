Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0903770C5D8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:13:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Aq3-0003ZZ-GY; Mon, 22 May 2023 15:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq0-0003Xa-29
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apv-0003a0-IE
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pWapplvdd5du0sdL+agLHH6q7YkeqEqOoWWCjN8cNM=;
 b=drcd1zT5IoJq/HzG4YkC150hGDuNkdl5qUffUfhJNIDOMrsfxT7zx/MsBUnMaimV4tAfVr
 yKU/gpwTAcRRTuKU7PgWA5IvkvS94rc4d4ZwhKTDrDhBWR1o0F0dapQSu+5dfmWXtC/QD6
 H5tytk+j5X6KTMRR2kV5Nuu24CXoS2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-Lm4wJazUPW-gEHyvZ5IFww-1; Mon, 22 May 2023 15:04:47 -0400
X-MC-Unique: Lm4wJazUPW-gEHyvZ5IFww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0436F185A795;
 Mon, 22 May 2023 19:04:47 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5DF3400DFF;
 Mon, 22 May 2023 19:04:46 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 06/19] cutils: Document differences between parse_uint and
 qemu_strtou64
Date: Mon, 22 May 2023 14:04:28 -0500
Message-Id: <20230522190441.64278-7-eblake@redhat.com>
In-Reply-To: <20230522190441.64278-1-eblake@redhat.com>
References: <20230522190441.64278-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These two functions are subtly different, and not just because of
swapped parameter order.  It took me adding better unit tests to
figure out why.  Document the differences to make it more obvious to
developers trying to pick which one to use, as well as to aid in
upcoming semantic changes.

While touching the documentation, adjust a mis-statement: parse_uint
does not return -EINVAL on invalid base, but assert()s, like all the
other qemu_strto* functions that take a base argument.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 util/cutils.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/util/cutils.c b/util/cutils.c
index 9b6ce9179c4..36c14b769fd 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -611,6 +611,8 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,
  * Convert string @nptr to an uint64_t.
  *
  * Works like qemu_strtoul(), except it stores UINT64_MAX on overflow.
+ * (If you want to prohibit negative numbers that wrap around to
+ * positive, use parse_uint()).
  */
 int qemu_strtou64(const char *nptr, const char **endptr, int base,
                   uint64_t *result)
@@ -721,7 +723,8 @@ const char *qemu_strchrnul(const char *s, int c)
  *
  * @s: String to parse
  * @value: Destination for parsed integer value
- * @endptr: Destination for pointer to first character not consumed
+ * @endptr: Destination for pointer to first character not consumed, must
+ * not be %NULL
  * @base: integer base, between 2 and 36 inclusive, or 0
  *
  * Parse unsigned integer
@@ -729,15 +732,16 @@ const char *qemu_strchrnul(const char *s, int c)
  * Parsed syntax is like strtoull()'s: arbitrary whitespace, a single optional
  * '+' or '-', an optional "0x" if @base is 0 or 16, one or more digits.
  *
- * If @s is null, or @base is invalid, or @s doesn't start with an
- * integer in the syntax above, set *@value to 0, *@endptr to @s, and
- * return -EINVAL.
+ * If @s is null, or @s doesn't start with an integer in the syntax
+ * above, set *@value to 0, *@endptr to @s, and return -EINVAL.
  *
  * Set *@endptr to point right beyond the parsed integer (even if the integer
  * overflows or is negative, all digits will be parsed and *@endptr will
  * point right beyond them).
  *
  * If the integer is negative, set *@value to 0, and return -ERANGE.
+ * (If you want to allow negative numbers that wrap around within
+ * bounds, use qemu_strtou64()).
  *
  * If the integer overflows unsigned long long, set *@value to
  * ULLONG_MAX, and return -ERANGE.
@@ -794,10 +798,10 @@ out:
  *
  * Parse unsigned integer from entire string
  *
- * Have the same behavior of parse_uint(), but with an additional check
- * for additional data after the parsed number. If extra characters are present
- * after the parsed number, the function will return -EINVAL, and *@v will
- * be set to 0.
+ * Have the same behavior of parse_uint(), but with an additional
+ * check for additional data after the parsed number. If extra
+ * characters are present after a non-overflowing parsed number, the
+ * function will return -EINVAL, and *@v will be set to 0.
  */
 int parse_uint_full(const char *s, unsigned long long *value, int base)
 {
-- 
2.40.1


