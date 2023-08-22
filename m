Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D743F7841E9
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:22:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRKN-0002n9-5p; Tue, 22 Aug 2023 09:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qYRKJ-0002mt-8j; Tue, 22 Aug 2023 09:21:43 -0400
Received: from m1328.mail.163.com ([220.181.13.28])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>)
 id 1qYRKF-00027V-5N; Tue, 22 Aug 2023 09:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=AXBN+yZ8wGC4XP0ZtZ7FvQeczV42BoTmHCvBhwmtZNA=; b=D
 tjUUJapg1fVnBZnPzCIOCkrQcnerAef+OgumE0q2XCH0EB2fqxwq0XdC23zFeA0O
 ICXmJUvVnsPXAO1f/+y7EsGlPjNQI6jQh74G9UsLpH8nI8bKMgT5Q4EN9JKPUMYI
 2zAhq+AxpltJoK/S3cFsXqJMRm4KScnNqtYn0xfNDU=
Received: from logoerthiner1$163.com ( [42.84.232.4] ) by
 ajax-webmail-wmsvr28 (Coremail) ; Tue, 22 Aug 2023 21:21:07 +0800 (CST)
X-Originating-IP: [42.84.232.4]
Date: Tue, 22 Aug 2023 21:21:07 +0800 (CST)
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
Subject: Re:[PATCH v2 8/9] docs: Don't mention "-mem-path" in multi-process.rst
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230822114504.239505-9-david@redhat.com>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-9-david@redhat.com>
X-NTES-SC: AL_QuySAPuav0wt4SabYukXnk4Shuc2XMu4u/gu34JTP5E0lSnV9yYMUlRMPnjb0duGBDGcmzOwbjZ05d9gUIJoZrptMnpuEVUQSHJuXW1yHk7n
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <37073b87.4601.18a1d67f837.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HMGowABH09pDtuRkNI8MAA--.58902W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBoQjTnmI0Z33K-wAEsZ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.28; envelope-from=logoerthiner1@163.com;
 helo=m1328.mail.163.com
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

SGVsbG8sCgpBdCAyMDIzLTA4LTIyIDE5OjQ0OjU2LCAiRGF2aWQgSGlsZGVuYnJhbmQiIDxkYXZp
ZEByZWRoYXQuY29tPiB3cm90ZToKPiItbWVtLXBhdGgiIGNvcnJlc3BvbmRzIHRvICJtZW1vcnkt
YmFja2VuZC1maWxlLHNoYXJlPW9mZiIgYW5kLAo+dGhlcmVmb3JlLCBjcmVhdGVzIGEgcHJpdmF0
ZSBDT1cgbWFwcGluZyBvZiB0aGUgZmlsZS4gRm9yIG11bHRpLXByb2Nlcwo+UUVNVSwgd2UgbmVl
ZCBwcm9wZXIgc2hhcmVkIGZpbGUtYmFja2VkIG1lbW9yeS4KPgo+TGV0J3MgbWFrZSB0aGF0IGNs
ZWFyZXIuCj4KPlNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPgo+LS0tCj4gZG9jcy9kZXZlbC9tdWx0aS1wcm9jZXNzLnJzdCB8IDUgKysrLS0KPiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0
IGEvZG9jcy9kZXZlbC9tdWx0aS1wcm9jZXNzLnJzdCBiL2RvY3MvZGV2ZWwvbXVsdGktcHJvY2Vz
cy5yc3QKPmluZGV4IGU0ODAxNzUxZjIuLjRlZjUzOWMwYjAgMTAwNjQ0Cj4tLS0gYS9kb2NzL2Rl
dmVsL211bHRpLXByb2Nlc3MucnN0Cj4rKysgYi9kb2NzL2RldmVsL211bHRpLXByb2Nlc3MucnN0
Cj5AQCAtNDA5LDggKzQwOSw5IEBAIHRoZSBpbml0aWFsIG1lc3NhZ2VzIHNlbnQgdG8gdGhlIGVt
dWxhdGlvbiBwcm9jZXNzIGlzIGEgZ3Vlc3QgbWVtb3J5Cj4gdGFibGUuIEVhY2ggZW50cnkgaW4g
dGhpcyB0YWJsZSBjb25zaXN0cyBvZiBhIGZpbGUgZGVzY3JpcHRvciBhbmQgc2l6ZQo+IHRoYXQg
dGhlIGVtdWxhdGlvbiBwcm9jZXNzIGNhbiBgYG1tYXAoKWBgIHRvIGRpcmVjdGx5IGFjY2VzcyBn
dWVzdAo+IG1lbW9yeSwgc2ltaWxhciB0byBgYHZob3N0X3VzZXJfc2V0X21lbV90YWJsZSgpYGAu
IE5vdGUgZ3Vlc3QgbWVtb3J5Cj4tbXVzdCBiZSBiYWNrZWQgYnkgZmlsZSBkZXNjcmlwdG9ycywg
c3VjaCBhcyB3aGVuIFFFTVUgaXMgZ2l2ZW4gdGhlCj4tKi1tZW0tcGF0aCogY29tbWFuZCBsaW5l
IG9wdGlvbi4KPittdXN0IGJlIGJhY2tlZCBieSBzaGFyZWQgZmlsZS1iYWNrZWQgbWVtb3J5LCBm
b3IgZXhhbXBsZSwgdXNpbmcKPisqLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxlLHNoYXJlPW9u
KiBhbmQgc2V0dGluZyB0aGF0IG1lbW9yeSBiYWNrZW5kCj4rYXMgUkFNIGZvciB0aGUgbWFjaGlu
ZS4KPiAKPiBJT01NVSBvcGVyYXRpb25zCj4gXl5eXl5eXl5eXl5eXl5eXgoKQWJvdXQgIi1tZW0t
cGF0aCIgYW5kICItb2JqZWN0IG1lbW9yeS1iYWNrZW5kLWZpbGUiLgoKSSBoYXZlIG1lbnRpb25l
ZCBhIGVycm9yIG1lc3NhZ2Ugc3VnZ2VzdGlvbiwgbWF5YmUgeW91IGNhbiBjb25zaWRlciBpdD8g
VGhlCmVycm9yIG1lc3NhZ2UgcmVsYXRlZCB0byAiLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxl
LGlkPXBjLnJhbSIgaXMgY29uZnVzaW5nLAphcyBpcyBzaG93biBiZWxvdzogKGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMzM3ZDlmLjE2ZDYuMTg5ZTg2ODI5MDEuQ29yZW1haWwubG9nb2Vy
dGhpbmVyMUAxNjMuY29tLykKCgo+IAo+IFdhaXQgLi4uIEkgdGhvdWdodCBpdCBzaG91bGQgbm90
IHdvcmsgYnV0IGl0IGRpZCB3b3JrIHRvZGF5LiBIb3cgYmFkIGFtIEkgYXQgcmVhZGluZwo+IHRo
ZSBjb3JyZWN0IHBhcnQgb2YgZG9jdW1lbnRhdGlvbiAuLi4KPiAKPiAnLW1hY2hpbmUgcTM1IC1t
IDUxMk0nIGlzIGVxdWl2YWxlbnQgdG8gJy1vYmplY3QKPiBtZW1vcnktYmFja2VuZC1maWxlLGlk
PXBjLnJhbSxzaXplPTUxMk0KPiAtbWFjaGluZSBxMzUsbWVtb3J5LWJhY2tlbmQ9cGMucmFtJywK
PiB0aGUgbGF0dGVyIHdvcmtzLCBhbmQgdGhlIHR3byBtZW50aW9uZWQgc2V0dXAgY2FuIGJlCj4g
bWlncmF0ZWQgZnJvbSBvbmUgdG8gYW5vdGhlci4KPiAKPiBXaGF0IEkgd2FzIGNvbnNpc3RlbnRs
eSB0cnlpbmcgd2FzICctb2JqZWN0Cj4gbWVtb3J5LWJhY2tlbmQtZmlsZSxpZD1wYy5yYW0sc2l6
ZT01MTJNIC1tYWNoaW5lIHEzNScsIGFuZCBxZW11IHJhaXNlcyBhbiBlcnJvcgo+IGZvciB0aGlz
IGluIGEgcmVjZW50IHVwZGF0ZToKPiAKPiBgYGAKPiBxZW11LXN5c3RlbS14ODZfNjQ6IG9iamVj
dCBuYW1lICdwYy5yYW0nIGlzIHJlc2VydmVkIGZvciB0aGUgZGVmYXVsdCBSQU0gYmFja2VuZCwg
aXQgY2FuJ3QgYmUgdXNlZCBmb3IgYW55IG90aGVyIHB1cnBvc2VzLiBDaGFuZ2UgdGhlIG9iamVj
dCdzICdpZCcgdG8gc29tZXRoaW5nIGVsc2UKPiBgYGAKPiAKPiBUaGlzIGVycm9yIGlzIG1pc2xl
YWRpbmcuIEFjdHVhbGx5IGluIHRoaXMgY2FzZSwgdGhlIGVycm9yIHJlcG9ydCBtZXNzYWdlIHNo
b3VsZCBiZSBtb3JlCj4gY2xvc2UgdG86Cj4gYGBgCj4gb2JqZWN0IG5hbWUgJ3BjLnJhbScgaXMg
cmVzZXJ2ZWQgZm9yIHRoZSBkZWZhdWx0IFJBTSBiYWNrZW5kLCBpdCBjYW4ndAo+IGJlIHVzZWQg
Zm9yIGFueSBvdGhlciBwdXJwb3Nlcy4gQ2hhbmdlIHRoZSBvYmplY3QncyAnaWQnIHRvIHNvbWV0
aGluZwo+IGVsc2UsIG9yIGFwcGVuZCAibWVtb3J5LWJhY2tlbmQ9cGMucmFtIiB0byAtbWFjaGlu
ZSBhcmd1bWVudHMKPiBgYGAKPiAKPiAoSSBzdWdnZXN0IHJld3JpdGluZyB0aGUgZXJyb3IgbWVz
c2FnZSBsaWtlIHRoaXMgc3RyaW5nIGJlY2F1c2Ugb2YgdGhlIGNvbmZ1c2lvbiBqdXN0IG5vdykK
PiAKPiAKPiBFdmVuIHRob3VnaCB0aGUgZGVmYXVsdCBtZW1vcnkgYmFja2VuZCBuYW1lIGlzIHBj
LnJhbSwgdGhlCj4gJy1tYWNoaW5lIHEzNSxtZW1vcnktYmFja2VuZD1wYy5yYW0nIHBhcnQgZXhw
bGljaXRseSBtYXJrcyB0aGF0IHFlbXUKPiB1c2VzIGEgbWVtb3J5IGJhY2tlbmQgbmFtZWQgcGMu
cmFtLCByYXRoZXIgdGhhbiByZWx5IG9uIGRlZmF1bHQuCj4gCj4gSXQgc2VlbXMgdGhhdCBpZiBp
dCAicmVseSBvbiBkZWZhdWx0IiBhbmQgbWVtb3J5LWJhY2tlbmQtZmlsZSBoYXMgYW4gaWQKPiBv
ZiAicGMucmFtIiAoaW4geDg2XzY0IG9mIGNvdXJzZSksIGl0IHdpbGwgZmFpbC4KPiAKPiBHcmVh
dC4gTm93IEkgd2lsbCBjb25zaWRlciB1c2luZyBhICItb2JqZWN0Cj4gbWVtb3J5LWJhY2tlbmQt
ZmlsZSxpZD1wYy5yYW0sc2l6ZT01MTJNCj4gLW1hY2hpbmUgcTM1LG1lbW9yeS1iYWNrZW5kPXBj
LnJhbSIKCi0tCgpSZWdhcmRzLAoKbG9nb2VydGhpbmVy

