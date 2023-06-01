Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EDC71F58B
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOb-00088U-DB; Thu, 01 Jun 2023 18:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qOE-00080y-GP
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO4-0003zt-Ij
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685656995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPPsWVR0U6xteWYRUrvPeNQcFUnYVMY8kJRb5ji6y3o=;
 b=H36qudFQX2sRXxem2ormkfuuVTRtQFY4zfhIzl/VjVqHFBOE8jbw/7pZug/m/2upGDSdEE
 fEb3tZa92bffBSIiu7m9p9K1xx4g3XEshhWc9KIUnqTpwiGVeD9BRFaEetq5GDb2+T+8pk
 F7/mdeovexS+EJKROFkjiDeLOla1+6k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-aw5m9S95NxiVF55VTZWwwA-1; Thu, 01 Jun 2023 18:03:14 -0400
X-MC-Unique: aw5m9S95NxiVF55VTZWwwA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D597811E78
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 22:03:14 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BD7B492B0A;
 Thu,  1 Jun 2023 22:03:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 08/21] cutils: Document differences between parse_uint and
 qemu_strtou64
Date: Thu,  1 Jun 2023 17:02:52 -0500
Message-Id: <20230601220305.2130121-9-eblake@redhat.com>
In-Reply-To: <20230601220305.2130121-1-eblake@redhat.com>
References: <20230601220305.2130121-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20230522190441.64278-7-eblake@redhat.com>
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


