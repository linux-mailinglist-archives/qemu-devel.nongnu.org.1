Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7369A76EE77
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:44:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRaTz-00074r-OQ; Thu, 03 Aug 2023 11:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logoerthiner1@163.com>)
 id 1qRaTx-00073f-F0
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:43:21 -0400
Received: from m13139.mail.163.com ([220.181.13.139])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <logoerthiner1@163.com>) id 1qRaTt-0006Rn-DL
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=lXDJrcBoE8lliCScoew1Tyic8fdVqjD/BMEtSqZh8Wo=; b=o
 QhOSFsu48HAbD5JlyuSjeGLvmSMZy0BJKRFyCMOmxWITVxhcKowqPZbyA8y/38JI
 39ivNRYt0NAWLLIAkq2Ij8sJgWQo5/5xmeM5Jj7iBqw4wGOcjhXvZFnDSuYs0zgX
 u0+5oHiCPq6DCaAlfWoVln/WnV/BT/ZgNf57L3Ov7I=
Received: from logoerthiner1$163.com ( [183.242.254.172] ) by
 ajax-webmail-wmsvr139 (Coremail) ; Thu, 3 Aug 2023 23:43:03 +0800 (CST)
X-Originating-IP: [183.242.254.172]
Date: Thu, 3 Aug 2023 23:43:03 +0800 (CST)
From: ThinerLogoer  <logoerthiner1@163.com>
To: "David Hildenbrand" <david@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
Subject: Ping: Re: [PATCH v2] softmmu/physmem: try opening file readonly
 before failure in file_ram_open
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <e2e82f40-2691-b947-bf06-bea0ded99eae@redhat.com>
References: <20230726145912.88545-1-logoerthiner1@163.com>
 <183e16a8-55c3-7550-a9ff-21f31f65d0e5@redhat.com>
 <6bdbce7f.3e8e.18997f05e47.Coremail.logoerthiner1@163.com>
 <e908495c-252c-745c-036b-1b19778435d9@redhat.com>
 <615091df.3495.1899b089fc8.Coremail.logoerthiner1@163.com>
 <e2e82f40-2691-b947-bf06-bea0ded99eae@redhat.com>
X-NTES-SC: AL_QuySA/ycuEsj5SSRZ+kXnk4Shuc2XMu4u/gu34JTP5E0uyvuyjo4eV9iNmLq7eSKEyyBkDiUXyN27MlHRKhAe48eyRmBGwrXPN+xY++w2tH/
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <358ce6fd.7806.189bc111547.Coremail.logoerthiner1@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: i8GowADH3TgHy8tkVOMNAA--.2133W
X-CM-SenderInfo: 5orj0vpuwkx0thurqiywtou0bp/xtbBZhm7nlaEEacWtQACsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.139;
 envelope-from=logoerthiner1@163.com; helo=m13139.mail.163.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

QXQgMjAyMy0wNy0yOCAxODo0NToyMCwgIkRhdmlkIEhpbGRlbmJyYW5kIiA8ZGF2aWRAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPgo+V2hhdGV2ZXIgeW91IHByZWZlciEgSWYgSSByZXNlbmQgdGhlIHBh
dGNoLCBJIHdvdWxkIGtlZXAgeW91IHRoZSBhdXRob3IgCj5hbmQgb25seSBhZGQgbXkgQ28tYXV0
aG9yZWQtYnk6IFNpZ25lZC1vZmYtYnk6Lgo+Cj5KdXN0IGxldCBtZSBrbm93Lgo+CgpIZWxsbywK
Ckkgd29uZGVyIHdoZXRoZXIgeW91IGhhdmUgcGxhbm5lZCB0byByZXN1Ym1pdCB0aGUgY3VycmVu
dCBwYXRjaCBhbnl0aW1lIHNvb24sIG9yIGlzIGl0IGFscmVhZHkKaW5zaWRlIHRoZSBwYXRjaCBx
dWV1ZT8KCi0tLQoKUmVnYXJkcywKCmxvZ29lcnRoaW5lcg==

