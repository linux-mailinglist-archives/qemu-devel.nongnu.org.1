Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA247EECB3
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:35:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3tNx-0007ru-19; Fri, 17 Nov 2023 02:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1584389042@qq.com>) id 1r3tNq-0007jJ-Cm
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:35:22 -0500
Received: from out162-62-57-210.mail.qq.com ([162.62.57.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1584389042@qq.com>) id 1r3tNk-0007Un-Ar
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1700206504; bh=JQP3G2hYc0pvEPsB15pNhsE1PGXF/F4yhfc3JDgo3Tg=;
 h=From:To:Subject:Date;
 b=WMUlO2+dq+IbEYidmSQLXhTe77xlkp2HDa8OvrXZNGMgB0x/HTELT65AhqMCF2rRT
 kExLAyGZIpzTikb3QT+dUsegix2E31ZDX2V8FrIzOOSKVj7EJZUKDN2ivMfrprLD83
 r/JOYglxBgKxHtjk0EtFP13KjlJf6BqJQJuc2hPw=
X-QQ-FEAT: oHWrrGTW1dCni6VLWI7Xi3lwP5c1dnPf
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-XMAILINFO: ODm3YadP5aQzYv61q87l9jfizUZ1dfp0GmYnrmyzjQBET66vSVkoTtF3uYImOl
 5NOI8vDyi0s/INOYCjc2sOaXkaHU0BnWWZLbacCFUwewFc9Y1X4dQvAaRwRNrRWU52oCrPAnfYTeX
 F+dareq0Lr4QkncJEX4nJVIpvH4CjDfwhhsePLspIbHf18eL3pPwq8324Gw6zvBPLoTVIMNSf7Fj1
 N5JKZAG0khaeKOrcD593tswCbYC9o8womJXfIQDI6EgxZGD0WauObQ3GMw/TZEZpQg2q9jyZ+kOVZ
 ++PEgic1eNK+7n/N9B3abv2ZNxaj3jABtYEGnrmhxze5CIuPr0xtyrR4bRCeR9LmzsTZeiX6nol8t
 AQHdJWUtwtu6Bvf/vbi1bxei/XbWapFfnahF1Mzt5KYPTWnkNbubekbFaMJnDvuE6Gy4MN+6KJeCN
 57stvh7lx6bBndrrkYxqQ/EzjM7UvDXhi5XWy6BJxE4sGLC9Vm9fy3pGXxqbc6LxSWD9kJFsBdRWM
 PtDllLebl57Q3xek3krsTBZ+J3HeIr8khgElbqoGoIigPICM/wf0V5cbSalCMyOloPwOL8qYabzXf
 1vISIoIHf4K9BdoNpnhNY7ZBjWeRLkvVYB65ZNJC9+cT5K6BGJeHq9n6YXP5uJQ3xqLrnsaWNmIdh
 VauiS2atvefKJJBFg06Ylss3zOitcdiQGn23Mjz4l5PQRByFK4dF16LezkU09vWf6I8SLVxnZ/Gww
 mlNn7Yy5PbfrqNiD6d8MVzlP1s0lXHbKDYTpvkccTyhmveST2tcl1jO2vGFxGt7BYOAz3knjC1YLc
 zhqMNyIVNNUnmvy7rQtO0VWkIOdWKLZHTA74HgpaIxB7Cot8JhyTKaz8tMOOy9pFrhyPuh1HoPJom
 +eGjOY6X5jeCGztIpT+jH4xvpAa3QpWC3ibDfTpdi4TyFWD1KziQDzma7zdwdPNAqph3ojkucVnmY
 kbv1CtRUtNw4sfODYZ9fG9+wy7llkuJXCzGUMQdA==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.16.180.156
X-QQ-STYLE: 
X-QQ-mid: webmail240t1700206310t237374
From: "=?gb18030?B?t70=?=" <1584389042@qq.com>
To: "=?gb18030?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: Assessment of the difficulty in porting CPU architecture for qemu
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_655716E5_17EE9120_1F8C20CF"
Content-Transfer-Encoding: 8Bit
Date: Fri, 17 Nov 2023 15:31:49 +0800
X-Priority: 3
Message-ID: <tencent_29796A8EF3E655396E27566AC5CE1103A509@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
Received-SPF: pass client-ip=162.62.57.210; envelope-from=1584389042@qq.com;
 helo=out162-62-57-210.mail.qq.com
X-Spam_score_int: 68
X-Spam_score: 6.8
X-Spam_bar: ++++++
X-Spam_report: (6.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45,
 NO_FM_NAME_IP_HOSTN=0.121, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: reject
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

------=_NextPart_655716E5_17EE9120_1F8C20CF
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64

Jm5ic3A7SGVsbG8gZXZlcnlvbmUhIEkgYW0gd29ya2luZyBvbiBpbXBsZW1lbnRpbmcgYSB0
b29sIHRvIGFzc2VzcyB0aGUgY29tcGxleGl0eSBvZiBDUFUgYXJjaGl0ZWN0dXJlIHBvcnRp
bmcuIEl0IHByaW1hcmlseSBmb2N1c2VzIG9uIFJJU0MtViBhcmNoaXRlY3R1cmUgcG9ydGlu
Zy4gSW4gZmFjdCwgdGhlIHRvb2wgbWF5IGhhdmUgYW4gYXZlcmFnZSBlc3RpbWF0ZSBvZiB2
YXJpb3VzIGFyY2hpdGVjdHVyZSBwb3J0aW5nIGVmZm9ydHMuTXkgZm9jdXMgaXMgb24gdGhl
IG92ZXJhbGwgd29ya2xvYWQgYW5kIGRpZmZpY3VsdHkgb2YgdHJhbnNwbGFudGF0aW9uIGlu
IHRoZSBwYXN0IGFuZCBmdXR1cmUsZXZlbiBpZiBhIHByb2plY3QgaGFzIGFscmVhZHkgYmVl
biBwb3J0ZWQuQXMgcGFydCBvZiBteSBkYXRhc2V0LCBJIGhhdmUgY29sbGVjdGVkIHRoZSAq
KnFlbXUqKiBwcm9qZWN0LiAqKkkgd291bGQgbGlrZSB0byBnYXRoZXIgY29tbXVuaXR5IG9w
aW5pb25zIHRvIHN1cHBvcnQgbXkgYXNzZXNzbWVudC4gSSBhcHByZWNpYXRlIHlvdXIgaGVs
cCBhbmQgcmVzcG9uc2UhKiogQmFzZWQgb24gc2Nhbm5pbmcgdG9vbHMsIHRoZSBwb3J0aW5n
IGNvbXBsZXhpdHkgaXMgZGV0ZXJtaW5lZCB0byBiZSBoaWdoLCB3aXRoIGEgc2lnbmlmaWNh
bnQgYW1vdW50IG9mIGNvZGUgcmVsYXRlZCB0byB0aGUgQ1BVIGFyY2hpdGVjdHVyZSBpbiB0
aGUgcHJvamVjdC4mbmJzcDsgSXMgdGhpcyBhc3Nlc3NtZW50IGFjY3VyYXRlP0RvIHlvdSBo
YXZlIGFueSBvcGluaW9ucyBvbiBwZXJzb25uZWwgYWxsb2NhdGlvbiBhbmQgY29uc3VtcHRp
b24gdGltZaO/IEkgbG9vayBmb3J3YXJkIHRvIHlvdXIgaGVscCBhbmQgcmVzcG9uc2Uu

------=_NextPart_655716E5_17EE9120_1F8C20CF
Content-Type: text/html;
	charset="gb18030"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9R0IxODAzMCI+PGRpdj4mbmJzcDtIZWxsbyBldmVyeW9uZSEgSSBhbSB3b3JraW5n
IG9uIGltcGxlbWVudGluZyBhIHRvb2wgdG8gYXNzZXNzIHRoZSBjb21wbGV4aXR5IG9mIENQ
VSBhcmNoaXRlY3R1cmUgcG9ydGluZy4gSXQgcHJpbWFyaWx5IGZvY3VzZXMgb24gUklTQy1W
IGFyY2hpdGVjdHVyZSBwb3J0aW5nLiBJbiBmYWN0LCB0aGUgdG9vbCBtYXkgaGF2ZSBhbiBh
dmVyYWdlIGVzdGltYXRlIG9mIHZhcmlvdXMgYXJjaGl0ZWN0dXJlIHBvcnRpbmcgZWZmb3J0
cy5NeSBmb2N1cyBpcyBvbiB0aGUgb3ZlcmFsbCB3b3JrbG9hZCBhbmQgZGlmZmljdWx0eSBv
ZiB0cmFuc3BsYW50YXRpb24gaW4gdGhlIHBhc3QgYW5kIGZ1dHVyZSxldmVuIGlmIGEgcHJv
amVjdCBoYXMgYWxyZWFkeSBiZWVuIHBvcnRlZC5BcyBwYXJ0IG9mIG15IGRhdGFzZXQsIEkg
aGF2ZSBjb2xsZWN0ZWQgdGhlICoqcWVtdSoqIHByb2plY3QuICoqSSB3b3VsZCBsaWtlIHRv
IGdhdGhlciBjb21tdW5pdHkgb3BpbmlvbnMgdG8gc3VwcG9ydCBteSBhc3Nlc3NtZW50LiBJ
IGFwcHJlY2lhdGUgeW91ciBoZWxwIGFuZCByZXNwb25zZSEqKiBCYXNlZCBvbiBzY2Fubmlu
ZyB0b29scywgdGhlIHBvcnRpbmcgY29tcGxleGl0eSBpcyBkZXRlcm1pbmVkIHRvIGJlIGhp
Z2gsIHdpdGggYSBzaWduaWZpY2FudCBhbW91bnQgb2YgY29kZSByZWxhdGVkIHRvIHRoZSBD
UFUgYXJjaGl0ZWN0dXJlIGluIHRoZSBwcm9qZWN0LiZuYnNwOyBJcyB0aGlzIGFzc2Vzc21l
bnQgYWNjdXJhdGU/RG8geW91IGhhdmUgYW55IG9waW5pb25zIG9uIHBlcnNvbm5lbCBhbGxv
Y2F0aW9uIGFuZCBjb25zdW1wdGlvbiB0aW1lo78gSSBsb29rIGZvcndhcmQgdG8geW91ciBo
ZWxwIGFuZCByZXNwb25zZS48L2Rpdj4=

------=_NextPart_655716E5_17EE9120_1F8C20CF--


