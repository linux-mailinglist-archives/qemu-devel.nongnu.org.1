Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D422788069
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 08:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQlQ-0006Pr-8P; Fri, 25 Aug 2023 02:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qZQlL-0006O8-Iz; Fri, 25 Aug 2023 02:57:43 -0400
Received: from m13102.mail.163.com ([220.181.13.102])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>)
 id 1qZQlH-0007kg-Ql; Fri, 25 Aug 2023 02:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=WBmppcMh++u7o298ODbTjDWtwFhGILnBCeJrucZrnZM=; b=p
 tF/wvjnauetBqbFKygT7Nwb9rOmubVxJt/mstOZM8syJ/2qI88HuSMHrDGKZbAb2
 LNuuQJd7XGWd7giXYW33X2tugjdO2LN72UdUfBR+nzAQMcgBdGbp2qX5hCoS/vh2
 eFYZmSVu/ZAXhUxazEnACqkyPiDgLPk/jbjIaowhrU=
Received: from logoerthiner1$163.com ( [42.84.232.6] ) by
 ajax-webmail-wmsvr102 (Coremail) ; Fri, 25 Aug 2023 14:57:04 +0800 (CST)
X-Originating-IP: [42.84.232.6]
Date: Fri, 25 Aug 2023 14:57:04 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: "David Hildenbrand" <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 "Paolo Bonzini" <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>, 
 "Igor Mammedov" <imammedo@redhat.com>, 
 =?GBK?Q?Philippe_Mathieu-Daud=A8=A6?= <philmd@linaro.org>, 
 =?GBK?Q?Daniel_P_=2E_Berrang=A8=A6?= <berrange@redhat.com>, 
 "Stefan Hajnoczi" <stefanha@redhat.com>, 
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>, 
 "Jagannathan Raman" <jag.raman@oracle.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, "Ani Sinha" <anisinha@redhat.com>, 
 "Xiao Guangrong" <xiaoguangrong.eric@gmail.com>, 
 "Daniel Henrique Barboza" <danielhb413@gmail.com>, 
 "Greg Kurz" <groug@kaod.org>, "Eric Blake" <eblake@redhat.com>, 
 "Markus Armbruster" <armbru@redhat.com>, 
 "Eduardo Habkost" <eduardo@habkost.net>
Subject: Re:[PATCH v3 11/11] machine: Improve error message when using
 default RAM backend id
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230823153412.832081-12-david@redhat.com>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-12-david@redhat.com>
X-NTES-SC: AL_QuySAPWfuU4p4iObYukXnk4Shuc2XMu4u/gu34JTP5E0kSv3yB8vb0FjLGTmyt+VLwOUjiaQWx912t9kUqpifYXAbrnYHy2AEcH1bSJ1Z/a5
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <209b4b8c.54bc.18a2b7b6f53.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZsGowACnWi_AUOhky8saAA--.9698W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBawDWnlet+ErxsgAAso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.102;
 envelope-from=logoerthiner1@163.com; helo=m13102.mail.163.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGVsbG8sCgpBdCAyMDIzLTA4LTIzIDIzOjM0OjExLCAiRGF2aWQgSGlsZGVuYnJhbmQiIDxkYXZp
ZEByZWRoYXQuY29tPiB3cm90ZToKPkZvciBtaWdyYXRpb24gcHVycG9zZXMsIHVzZXJzIG1pZ2h0
IHdhbnQgdG8gcmV1c2UgdGhlIGRlZmF1bHQgUkFNCj5iYWNrZW5kIGlkLCBidXQgc3BlY2lmeSBh
IGRpZmZlcmVudCBtZW1vcnkgYmFja2VuZC4KPgo+Rm9yIGV4YW1wbGUsIHRvIHJldXNlICJwYy5y
YW0iIG9uIHEzNSwgb25lIGhhcyB0byBzZXQKPiAgICAtbWFjaGluZSBxMzUsbWVtb3J5LWJhY2tl
bmQ9cGMucmFtCj5Pbmx5IHRoZW4sIGNhbiBhIG1lbW9yeSBiYWNrZW5kIHdpdGggdGhlIGlkICJw
Yy5yYW0iIGJlIGNyZWF0ZWQKPm1hbnVhbGx5Lgo+Cj5MZXQncyBpbXByb3ZlIHRoZSBlcnJvciBt
ZXNzYWdlLgo+Cj5VbmZvcnR1YW50ZWx5LCB3ZSBjYW5ub3QgdXNlIGVycm9yX2FwcGVuZF9oaW50
KCksIGJlY2F1c2UgdGhlIGNhbGxlcgo+cGFzc2VzICZlcnJvcl9mYXRhbC4KPgo+U3VnZ2VzdGVk
LWJ5OiBUaGluZXJMb2dvZXIgPGxvZ29lcnRoaW5lcjFAMTYzLmNvbT4KPlNpZ25lZC1vZmYtYnk6
IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPgo+LS0tCj4gaHcvY29yZS9tYWNo
aW5lLmMgfCA0ICsrKy0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCj4KPmRpZmYgLS1naXQgYS9ody9jb3JlL21hY2hpbmUuYyBiL2h3L2NvcmUvbWFjaGlu
ZS5jCj5pbmRleCBmMGQzNWM2NDAxLi5kYmNkMTI0ZDQ1IDEwMDY0NAo+LS0tIGEvaHcvY29yZS9t
YWNoaW5lLmMKPisrKyBiL2h3L2NvcmUvbWFjaGluZS5jCj5AQCAtMTM4Miw3ICsxMzgyLDkgQEAg
dm9pZCBtYWNoaW5lX3J1bl9ib2FyZF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgY29uc3Qg
Y2hhciAqbWVtX3BhdGgsIEVycm9yICoKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtYWNoaW5lX2NsYXNzLT5kZWZhdWx0X3JhbV9pZCkpIHsKPiAgICAgICAgICAgICBlcnJvcl9z
ZXRnKGVycnAsICJvYmplY3QgbmFtZSAnJXMnIGlzIHJlc2VydmVkIGZvciB0aGUgZGVmYXVsdCIK
PiAgICAgICAgICAgICAgICAgIiBSQU0gYmFja2VuZCwgaXQgY2FuJ3QgYmUgdXNlZCBmb3IgYW55
IG90aGVyIHB1cnBvc2VzLiIKPi0gICAgICAgICAgICAgICAgIiBDaGFuZ2UgdGhlIG9iamVjdCdz
ICdpZCcgdG8gc29tZXRoaW5nIGVsc2UiLAo+KyAgICAgICAgICAgICAgICAiIENoYW5nZSB0aGUg
b2JqZWN0J3MgJ2lkJyB0byBzb21ldGhpbmcgZWxzZSBvciBkaXNhYmxlIgo+KyAgICAgICAgICAg
ICAgICAiIGF1dG9tYXRpYyBjcmVhdGlvbiBvZiB0aGUgZGVmYXVsdCBSQU0gYmFja2VuZCBieSBz
ZXR0aW5nIgo+KyAgICAgICAgICAgICAgICAiIHRoZSAnbWVtb3J5LWJhY2tlbmQnIG1hY2hpbmUg
cHJvcGVydHkiLAo+ICAgICAgICAgICAgICAgICBtYWNoaW5lX2NsYXNzLT5kZWZhdWx0X3JhbV9p
ZCk7Cj4gICAgICAgICAgICAgcmV0dXJuOwo+ICAgICAgICAgfQoKSSdkIHN1Z2dlc3QgYSBtb3Jl
IGV4cGxpY2l0IHZlcnNpb246CgogICAgICAgICAgICAgICAgIiBDaGFuZ2UgdGhlIG9iamVjdCdz
ICdpZCcgdG8gc29tZXRoaW5nIGVsc2Ugb3IgZGlzYWJsZSIKICAgICAgICAgICAgICAgICIgYXV0
b21hdGljIGNyZWF0aW9uIG9mIHRoZSBkZWZhdWx0IFJBTSBiYWNrZW5kIGJ5IGFwcGVuZGluZyIK
ICAgICAgICAgICAgICAgICIgICdtZW1vcnktYmFja2VuZD17bWFjaGluZV9jbGFzcy0+ZGVmYXVs
dF9yYW1faWR9JyBpbiAnLW1hY2hpbmUnIGFyZ3VtZW50cyIsCgpBbGwgb3RoZXIgcGF0Y2hlcyBh
cmUgZ29vZCBvbiBteSBlbnZpcm9ubWVudCwgYXBwbGljYWJsZSBvbiA4LjEuMC4KCi0tCgpSZWdh
cmRzLAoKbG9nb2VydGhpbmVy

