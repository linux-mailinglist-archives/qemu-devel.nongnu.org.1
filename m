Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F804770C75
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 01:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS4Pr-00045z-Cf; Fri, 04 Aug 2023 19:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <negge@xiph.org>) id 1qS4Pp-00045n-Q8
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 19:41:05 -0400
Received: from mailfish.xiph.osuosl.org ([140.211.166.35]
 helo=mailfish.xiph.org) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <negge@xiph.org>) id 1qS4Pm-0000F8-2o
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 19:41:05 -0400
Received: from [192.168.0.104] (c-24-126-94-29.hsd1.va.comcast.net
 [24.126.94.29])
 by mailfish.xiph.org (Postfix) with ESMTPSA id 399729F798;
 Fri,  4 Aug 2023 23:40:55 +0000 (UTC)
To: qemu-devel@nongnu.org
References: 
Subject: [PATCH v9 07/24] linux-user: Do not call get_errno() in do_brk()
Cc: richard.henderson@linaro.org, akihiko.odaki@daynix.com, deller@gmx.de
From: Nathan Egge <negge@xiph.org>
Message-ID: <d83d4d31-dabd-5f05-e173-cbe255e26aed@xiph.org>
Date: Fri, 4 Aug 2023 19:40:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=140.211.166.35; envelope-from=negge@xiph.org;
 helo=mailfish.xiph.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2023-08-04 18:00, Richard Henderson wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Later the returned value is compared with -1, and negated errno is not
> expected.
>
> Fixes: 00faf08c95 ("linux-user: Don't use MAP_FIXED in do_brk()")
> Reviewed-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20230802071754.14876-4-akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 95727a816a..b9d2ec02f9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -862,9 +862,9 @@ abi_long do_brk(abi_ulong brk_val)
>       */
>      if (new_host_brk_page > brk_page) {
>          new_alloc_size = new_host_brk_page - brk_page;
> -        mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
> -                                        PROT_READ|PROT_WRITE,
> -                                        MAP_ANON|MAP_PRIVATE, 0, 0));
> +        mapped_addr = target_mmap(brk_page, new_alloc_size,
> +                                  PROT_READ|PROT_WRITE,
> +                                  MAP_ANON|MAP_PRIVATE, 0, 0);
>      } else {
>          new_alloc_size = 0;
>          mapped_addr = brk_page;
> -- 
> 2.34.1

This patch is triggering a gitlab pipeline failure in Richard's tcg-next 
branch:

https://gitlab.com/rth7680/qemu/-/pipelines/956532662

It can be reproduced locally by adding a git remote for rth7680 and then 
running:

$ git checkout rth7680/tcg-next
$ .gitlab-ci.d/check-patch.py

Checking all commits since c26d005e62f4fd177dae0cd70c24cb96761edebc...

f7cca41b17c809958a7f04b7d7f64af40d64e645:31: ERROR: spaces required 
around that '|' (ctx:VxV)
f7cca41b17c809958a7f04b7d7f64af40d64e645:32: ERROR: spaces required 
around that '|' (ctx:VxV)
total: 2 errors, 0 warnings, 12 lines checked
     ❌ FAIL one or more commits failed scripts/checkpatch.pl

The linux-user/syscall.c has many such places where this style check is 
failing. Should these be fixed in a separate patch?

Sincerely,

Nathan

