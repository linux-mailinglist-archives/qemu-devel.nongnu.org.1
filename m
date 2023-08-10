Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33119778373
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 00:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUDns-0004Z5-B3; Thu, 10 Aug 2023 18:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUDnq-0004Ya-0s
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:06:46 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qUDno-0006yV-6D
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 18:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691705196; x=1692309996; i=deller@gmx.de;
 bh=7XAMomkloIh7sTw6wn/3aiYK+5IwwbBgzar/GJzAV7s=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ncLF3+m14E3CIuFgYTNpm/Z851EZfgOsFOawDFRosmVjveJtLsh/z2rkldsbg6cVhsf9d4w
 uFDhGtKN3IBTnWvqKMlNJBDUF03UgkCCWx076aj2+YECmkeBdV+/2tltPmjJ/r10ZFYW8x/VX
 CunVJ9zgt6KDwVW3B6hpaQaklNMCS1GsZPPzsKjoTlsIjzuaDDKsJPIKa1x4hp69MbrlbLgQG
 zorOE0gnKyWcADS+gYu3UEWTFxfPkMbofnsFki26+q5tYCiM0DxXGkK2zGkhHZ0Xr2/vAvcni
 kEGHHOSxdqVDYhEci6ZA99w6Qy/2piF6FMyT7P/3plZBZaH+E2FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.133]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1qcDsK3PFv-00AmeS; Fri, 11
 Aug 2023 00:06:35 +0200
Message-ID: <d4d910af-beea-c173-5fde-f863031ba45e@gmx.de>
Date: Fri, 11 Aug 2023 00:06:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 v10 10/14] util/selfmap: Rewrite using
 qemu/interval-tree.h
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-11-richard.henderson@linaro.org>
 <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org>
 <0b00937cb4643ef19029e48d1de2a90c3614c3b5.camel@linux.ibm.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <0b00937cb4643ef19029e48d1de2a90c3614c3b5.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VIcWWgr8jlcMslkGCIOW2y8PXeWb7w3baEADBSU+omuO5o04BMu
 CJ1VE/q1kMFU4tueYdz9CXGYcmPGgE9+QZLKtlspBhhL55L7tPNht8Obb+RkPOMof+lzysj
 6TiENiAW9YKR1xOWjzpOpDjCJpB9/OeOM0hCmmrDaDarSE4mTolSmJb7nU7tQiHYxybr9nx
 9g0wsjeL7PfJ+preOamQQ==
UI-OutboundReport: notjunk:1;M01:P0:qH7r9+h6DP4=;sHxxY7wec0qfKDn4hEd0r1OkDSv
 eioBjyd1HZ25U2+mSc1QYb56Ph0DPGlsV+nrKgYB15LkvC1mkzW5ic28pKgtL/YmPtD7RK53b
 jHlGlaaDgcVGqBcSPD7rg4rzSYazWR1LY9tlHshkCnyJcWEwlHunwJj4nzMhIG1EdTMHyPl46
 VuNzwyfJR8MSTmsruBGgLAl3O5UsSEFFlfPonoPUllERV9zjFfbNiXB1wMMPjYu4KRJ9SO5pP
 dgCzIo9eGWUh57IkjLZrc+OyJwi/PYIa/mG0J0GXw3Cq6KYhj8Qrq7ILq9ew33e9wQORJuigb
 6wfgHJczYtL/jQMhCBCN3X93ZD+pEe1Oijqs4ByluaQu6uvJutm63jjFkMj5Iv3w4QtD3plpx
 5PzIfcTAD3yzdfkQ+ddA/SAA4AEtK8hCJAaqqVv1nMG4FezfMMsQey/9aOPYQCqtL4yBGV9+C
 KiOA2qeOezAVWEofuekwYk2aOcQu5IJIf8T1+rBSq98VT8pYZXVTty84v/Uqag+16D97sWkN6
 ADR54FdMj9alGha1sD2R/J7RB3pZmG4gZojURK3MJmfwX/iL/d6uA3VxbVGdEzRKnrgPO+EfI
 LT7e9KktDD7poTDLDlqmcrVGRzUkW37VcnpgOc+prZc7JdMY6O/0NaSpErbSKjlUbcK1hVDhj
 q8yrI+8xjszNq6eIRM2It1XA5KaHi3X3jNg31kPo+9NLGBKhAMP4eNgnUgnR1TVW7yiXG4G0t
 V/li4+9gcgpgNTY/X3reE7/koRMFwm0LOcNnaKS2oIFJEMlFXdr0EjzFLW4JZQxBhHRO5ZzJL
 av0QjJ56F9TC6145qZnBD9ImC0a8Pw1aEGFJtMakXTCtgrWrlbyBQNrmh7+Wc9TZXdarg5ZCg
 sfz0HCDZ6aLtBDVixk8wrRRNc5xFEKvAFciRpkZFuzNL3hVT67VXJZWhdmsjLkBgtDcx8BfZp
 BRU6lYekSxgcMlTsUiMKNqmFAYE=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-2.156, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 8/10/23 23:31, Ilya Leoshkevich wrote:
> On Mon, 2023-08-07 at 11:17 -0700, Richard Henderson wrote:
>> On 8/7/23 09:37, Richard Henderson wrote:
>>> We will want to be able to search the set of mappings.
>>> For this patch, the two users iterate the tree in order.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  =C2=A0 include/qemu/selfmap.h |=C2=A0 20 ++++----
>>>  =C2=A0 linux-user/elfload.c=C2=A0=C2=A0 |=C2=A0 14 +++--
>>>  =C2=A0 linux-user/syscall.c=C2=A0=C2=A0 |=C2=A0 15 +++---
>>>  =C2=A0 util/selfmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 114 +++++++++++++++++++++++++-----------
>>> -----
>>>  =C2=A0 4 files changed, 96 insertions(+), 67 deletions(-)
>>
>> I should note that, for 8.2, this will enable a rewrite of
>> open_self_maps_1 so that it
>> does not require page-by-page checking of page_get_flags.
>>
>> My idea is that open_self_maps_1 would use walk_memory_regions to see
>> all guest memory
>> regions.=C2=A0 The per-region callback would cross-check with the host-
>> region interval tree to
>> find the dev+inode+path.
>>
>> Cc Ilya and Helge, since there are two outstanding changes to
>> open_self_maps.

I think the rewrite is good.
My patches regarding the map aren't important, I can adjust them
afterwards and resend (if necessary).

Helge

