Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E105473DF07
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlFU-0006DX-FS; Mon, 26 Jun 2023 08:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDlFB-00068d-QY; Mon, 26 Jun 2023 08:22:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDlF9-0001Ja-Qp; Mon, 26 Jun 2023 08:22:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 28471ED67;
 Mon, 26 Jun 2023 15:22:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 35363F654;
 Mon, 26 Jun 2023 15:22:42 +0300 (MSK)
Message-ID: <cec99847-86d5-40ed-6f87-b0e9106d403b@tls.msk.ru>
Date: Mon, 26 Jun 2023 15:22:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL v2 1/3] target/hppa: Fix OS reboot issues
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230624115007.30332-1-deller@gmx.de>
 <20230624115007.30332-2-deller@gmx.de>
 <c2917053-e8df-c2bc-9565-6d5f257db901@tls.msk.ru>
 <6a7e29ed-3ce9-c228-2d29-96151a5f8ccb@gmx.de>
 <45215ee6-b36f-5c90-6937-9f45277598ea@gmx.de>
From: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable <qemu-stable@nongnu.org>, Michael Roth <michael.roth@amd.com>
In-Reply-To: <45215ee6-b36f-5c90-6937-9f45277598ea@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

25.06.2023 14:20, Helge Deller wrote:

>>> Is this a -stable material?  It applies cleanly to 8.0 and 7.2.
>>
>> Yes, please.
>> At least for 8.0 I think it should be added.
>> I didn't tested 7.2, but can do and would prefer it if could be added there too.
> 
> Just tested: The patches work nicely when applied to v7.2 as well.
> Could you add them to -stable (or what is the process)?

Hmm. Now I'm a bit confused.

Initially I thought it's just this patch, 1/3, "target/hppa: Fix OS reboot issues",
to which I replied, is the one which should perhaps go to -stable.  But now I see
it is the whole series, all 3 changes, which are needed.

And for 7.2, things are a bit more interesting in this context: seabios-hppa version
in 7.2 is 6, it changed to version 7 in qemu 8.0, and changed further by this patchset.
There isn't much differences between seabios-hppa 6 and 7, so it's probably okay to
have it of version 7 in qemu-7.2-stable too (esp. since the change in there is another
bugfix, with debian 12 as a reproducer).

So, just to confirm: do we update seabios-hppa to this commit 673d2595d4f773cc266cbf
(version 8) in both stable-7.2 and stable-8.0? :)

The changes in there seems to be okay anyway, should be good to have in -stable.

Besides, I'm having sort of difficult time cherry-picking the commit which updates
seabios-hppa submodule and hppa-firmware.img file, - git tells me there's a conflict
(even when applying to stable-8.0 branch) but I see no changes to this areas in-
between (yes, a conflict when applying to 7.2 is expected).  So I ended up in
doing:

staging-8.0$ git cherry-pick -xs 34ec3aea54368a92b62a55c656335885ba8c65ef

error: Could not read 20cf9c785c3aa493a39be532642883a7a1dc360c
warning: Cannot merge binary files: pc-bios/hppa-firmware.img (HEAD vs. 34ec3aea54 (target/hppa: Update to SeaBIOS-hppa version 8))
Auto-merging pc-bios/hppa-firmware.img
CONFLICT (content): Merge conflict in pc-bios/hppa-firmware.img
Failed to merge submodule roms/seabios-hppa (commits don't follow merge-base)
CONFLICT (submodule): Merge conflict in roms/seabios-hppa
Recursive merging with submodules currently only supports trivial cases.
Please manually handle the merging of each conflicted submodule.
This can be accomplished with the following steps:
  - go to submodule (roms/seabios-hppa), and either merge commit 673d2595
    or update to an existing commit which has merged those changes
  - come back to superproject and run:

       git add roms/seabios-hppa

    to record the above merge or update
  - resolve any other conflicts in the superproject
  - commit the resulting index in the superproject
error: could not apply 34ec3aea54... target/hppa: Update to SeaBIOS-hppa version 8
hint: After resolving the conflicts, mark them with
hint: "git add/rm <pathspec>", then run
hint: "git cherry-pick --continue".
hint: You can instead skip this commit with "git cherry-pick --skip".
hint: To abort and get back to the state before "git cherry-pick",
hint: run "git cherry-pick --abort".

staging-8.0$ git checkout 34ec3aea54368a92b62a55c656335885ba8c65ef roms/seabios-hppa pc-bios/hppa-firmware.img

Updated 1 path from dc78364a05

staging-8.0$ git status

On branch staging-8.0
You are currently cherry-picking commit 34ec3aea54.
   (all conflicts fixed: run "git cherry-pick --continue")
   (use "git cherry-pick --skip" to skip this patch)
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)

Changes to be committed:
	modified:   pc-bios/hppa-firmware.img
	modified:   roms/seabios-hppa

staging-8.0$ git cherry-pick --continue
(commit changes)

Yes, this moves us to the right contents of both the submodule and the binary
file (the same as on master), but I don't see why it goes the way it goes.


Besides, it looks like this is the first change to submodules within qemu-stable
series..


Thanks,

/mjt

