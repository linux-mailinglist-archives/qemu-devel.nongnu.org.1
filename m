Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA6A39E0A
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Feb 2025 14:56:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkO4Z-0005zS-5z; Tue, 18 Feb 2025 08:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1058183524@qq.com>) id 1tkHxW-00049C-2C
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:23:58 -0500
Received: from out203-205-221-192.mail.qq.com ([203.205.221.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1058183524@qq.com>) id 1tkHxR-0003EP-Rn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1739863423; bh=gB6NppJyFdV7HnXW69F6s3qqjG41vmtV3bwZKea47lU=;
 h=From:To:Subject:Date;
 b=sr106cr9MMG0gQY4qL05XGJS4bKcEwH5lnlNILlHuboYwElGbZYS5iUchhE9xcCZB
 cmcrWW9uSk7dDpH6y3/l34oCjB8dlgEA0jeJ/nQStQO6JxA9UErZ7goO7EF6KLbuDI
 ZJNrwX8YeqH1qvesxqsSA3tesYwvi/zjRFhOEUaE=
X-QQ-FEAT: Xqh9UYnCrXCgeKC+InpiQr4XE5GGFGxU
X-QQ-SSF: 0000000000000080000000000000
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-XMAILINFO: MGu0d518fybeO0G/dMmjlVJGY/9/ZHQTsXcdbM9AoMxQf5QFSiV7PAeuVe4dSk
 RD1U9yo91z3T5U35BNc3vXy8iswLDmnavgvFDO1oEfZxAB+bJsOVR4ynHOdSQt0QWtUEkRohQZPzc
 pMxEsfmwhMyWNetTGBBjfDJkaqahBcV/kb5Z/pqPr912J6ZcPEGsMoAzh/2dkCJVbfOJmHLQSV/e7
 5rBzHMR8Iapx8poTbJRyDx/8QFImqBVx1TJXXTaCsK0T4+DA+Ezzn/EU3bL2GEZ0pTGWCezG6XfVm
 F47nB7wbkgOF29VdEDepjJBXeTMvByjh2WN2rXLTQY1DpCXfmgnyDohWXLQ0M15jCmM+iBCYOS7vs
 iQebP0ZjMzBRBURh8AqSgMJoABBPtW+axG4mAJklDchMMjF5wtns6ktef/i0iSuhFcJLBkSkFxURU
 nOjvNr58J1RZeyq5uX0s7vHqpbVbxId5aOTxO4Y0Fr+PAXlAUt3xOUKLU5lNZX5VZ54vwa6kTDi3t
 aRtwdWRt27H6i6WgQE2WXUqhbxsRjeyzmw4bXdC9OlBwguRnFR3oEoof6HpPcmCjl5ZdyvfZkvDqG
 56xyUNgV0AU2bkQQJaO2arvTJqAkKIck4EdtCIFId2+UYrc4KhT5qYktRjweHgq65wIcNSo4lWYzr
 KiF3k6Dhxi3UEAyk4k37dh7+2aRp3H0CMAkBHGsIoOk9yO2Hxct6Y4wy/qubY0HfM5tV4qycc9rHL
 +jnnNODFj69uDUfjBufb4UF7NMD/rjgOX6t8TuPeJ9zkUvB/+3goFsurQ8V0u00/I1hZbjKWFvv2p
 VCPtP/FIliS+Tx4+/n32j4uApINuozgKKVNyrOZhbIucR6mlVN5I1FsLW/Z3rQlOeeCfS4K3w3m20
 8FbLpTozo0A2p0gkHk5YYvE9fzNrjJ/901IbDuJ5oIXT6Aw2Zkizoz9DtALbHfVNtj8yFUCGtht1g
 Ml8EdAWlIbj2EwKDzY
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 210.40.230.67
X-QQ-STYLE: 
X-QQ-mid: webmail369t1739862432t202164
From: "=?gb18030?B?wLbJq7XEw87P6w==?=" <1058183524@qq.com>
To: "=?gb18030?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: Perf in QEMU
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_67B431A0_172BA910_69A52103"
Content-Transfer-Encoding: 8Bit
Date: Tue, 18 Feb 2025 15:07:12 +0800
X-Priority: 3
Message-ID: <tencent_308D5C2C7DFE0CDC38AD1906113460287F05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Received-SPF: pass client-ip=203.205.221.192; envelope-from=1058183524@qq.com;
 helo=out203-205-221-192.mail.qq.com
X-Spam_score_int: 67
X-Spam_score: 6.7
X-Spam_bar: ++++++
X-Spam_report: (6.7 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45,
 NO_FM_NAME_IP_HOSTN=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: reject
X-Mailman-Approved-At: Tue, 18 Feb 2025 08:55:35 -0500
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

This is a multi-part message in MIME format.

------=_NextPart_67B431A0_172BA910_69A52103
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64

SGVsbG8hDQoNCiZuYnNwOyZuYnNwOyZuYnNwOyBJIGFtIGEgZ3JhZHVhdGUgc3R1ZGVudCBj
dXJyZW50bHkgc3R1ZHlpbmcgaW4gc2Nob29sLiBSZWNlbnRseSwgSSB1c2VkIFFFTVUgOS4w
LjIgdG8gY3JlYXRlIHZpcnR1YWwgbWFjaGluZXMgd2l0aCBBUk0sIHg4NiwgYW5kIFJJU0Mt
ViBhcmNoaXRlY3R1cmVzIGZvciBleHBlcmltZW50cy4gRHVyaW5nIHRoZSBwcm9jZXNzLCBJ
IGZvdW5kIHRoYXQgdGhlIKGucGVyZiBzdGF0oa8gY29tbWFuZCBkb2VzIG5vdCBzdXBwb3J0
IHRoZSBjb2xsZWN0aW9uIG9mIGNlcnRhaW4gbWV0cmljcywgc3VjaCBhczogaW5zdHJ1Y3Rp
b25zLCBjYWNoZS1taXNzZXMsIGNhY2hlLXJlZmVyZW5jZXMsIGV0Yy4gSSBhbSB1bnN1cmUg
d2hldGhlciB0aGlzIGlzc3VlIGlzIGR1ZSB0byBteSBvcGVyYXRpb25zIG9yIGlmIFFFTVUg
aXRzZWxmIGRvZXMgbm90IHN1cHBvcnQgdGhlc2UgbWV0cmljcy4gDQoNCiZuYnNwOyZuYnNw
OyZuYnNwOyBUaGVyZWZvcmUsIEkgd291bGQgbGlrZSB0byBhc2sgeW91IHdoZXRoZXIgUUVN
VSB2aXJ0dWFsIG1hY2hpbmVzIHN1cHBvcnQgdGhlIGNvbGxlY3Rpb24gb2YgdGhlIGFib3Zl
IG1ldHJpY3MuDQoNCiZuYnNwOyZuYnNwOyZuYnNwOyBJIGFwb2xvZ2l6ZSBmb3IgYm90aGVy
aW5nIHlvdSwgYW5kIEkgaG9wZSB5b3Ugd2lsbCBiZSBhYmxlIHRvIHJlcGx5IGF0IHlvdXIg
Y29udmVuaWVuY2UuIFRoYW5rIHlvdSB2ZXJ5IG11Y2gh

------=_NextPart_67B431A0_172BA910_69A52103
Content-Type: text/html;
	charset="gb18030"
Content-Transfer-Encoding: base64

SGVsbG8hPGJyPjxicj4mbmJzcDsmbmJzcDsmbmJzcDsgSSBhbSBhIGdyYWR1YXRlIHN0dWRl
bnQgY3VycmVudGx5IHN0dWR5aW5nIGluIHNjaG9vbC4gUmVjZW50bHksIEkgdXNlZCBRRU1V
IDkuMC4yIHRvIGNyZWF0ZSB2aXJ0dWFsIG1hY2hpbmVzIHdpdGggQVJNLCB4ODYsIGFuZCBS
SVNDLVYgYXJjaGl0ZWN0dXJlcyBmb3IgZXhwZXJpbWVudHMuIER1cmluZyB0aGUgcHJvY2Vz
cywgSSBmb3VuZCB0aGF0IHRoZSChrnBlcmYgc3RhdKGvIGNvbW1hbmQgZG9lcyBub3Qgc3Vw
cG9ydCB0aGUgY29sbGVjdGlvbiBvZiBjZXJ0YWluIG1ldHJpY3MsIHN1Y2ggYXM6IGluc3Ry
dWN0aW9ucywgY2FjaGUtbWlzc2VzLCBjYWNoZS1yZWZlcmVuY2VzLCBldGMuIEkgYW0gdW5z
dXJlIHdoZXRoZXIgdGhpcyBpc3N1ZSBpcyBkdWUgdG8gbXkgb3BlcmF0aW9ucyBvciBpZiBR
RU1VIGl0c2VsZiBkb2VzIG5vdCBzdXBwb3J0IHRoZXNlIG1ldHJpY3MuIDxicj48YnI+Jm5i
c3A7Jm5ic3A7Jm5ic3A7IFRoZXJlZm9yZSwgSSB3b3VsZCBsaWtlIHRvIGFzayB5b3Ugd2hl
dGhlciBRRU1VIHZpcnR1YWwgbWFjaGluZXMgc3VwcG9ydCB0aGUgY29sbGVjdGlvbiBvZiB0
aGUgYWJvdmUgbWV0cmljcy48YnI+PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBJIGFwb2xvZ2l6
ZSBmb3IgYm90aGVyaW5nIHlvdSwgYW5kIEkgaG9wZSB5b3Ugd2lsbCBiZSBhYmxlIHRvIHJl
cGx5IGF0IHlvdXIgY29udmVuaWVuY2UuIFRoYW5rIHlvdSB2ZXJ5IG11Y2ghPGJyPjxicj4=

------=_NextPart_67B431A0_172BA910_69A52103--


