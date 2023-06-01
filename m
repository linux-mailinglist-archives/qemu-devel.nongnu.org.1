Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F458719A35
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 12:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4fut-00048N-7U; Thu, 01 Jun 2023 06:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4fur-00047t-2t
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:52:25 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4fup-0002vq-EI
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T7xX1XY/uq5SjfQ2gzsF0FReFGe+w9Bk7z/7787jI+A=; b=hkrYeeY8cnFYjnk+sjtmeFNWag
 gBzkgR9Cne87VeR+ILM3wk/oH6C4aL8CfnHrnJcAG09BSqlo4IaLUcC4mfGBR09ebUJdwgD5tUP3n
 bwOqwAUXatcc9hmOrQJBQvbchIsiuCZzWOeYLuiXQCMK+9/7WGS8VHuBi58ramoxhOh8+N9THB3HQ
 cVvHszwNbaFBwRXEeetDIH3XYxkuEmqFAbSD+gkF2AO8wLXHIvJQmPKQqTHYLMH1xrPyt8WrnMZ14
 uKHnThIrbVeCQe28a+yiYCpv5DzMtqJGdP7FyQsvBLX2hJaqkVvVG8o1uiRbgogkUEDYHxZe3fpMf
 5ic14PLigeQmErzCEjCc9vS8+epWE74d0VqAsGpdwFrIyxQyY27frFEYVR38WewOaHRPafQhsWfrU
 I+L7O9WKdIDIyW8YTRog76HJFlSj3tOboPoy1pb2tHHc2Gp3rmKSndusPMcY9JNmFInebJhXMJ+UX
 abiYtoPQtoccuwLVebGhPOp85BekoiYQb9LK65tdz75rlPOvughl8mfIrneJLABrHX+kgb4+kTo43
 0SQ0CojDG1tWN6kvTcqeXj0dD9kkM0daNXULk4/9xallowzhzv2WULuhZMRYmg62LAwva1OXywjTD
 G9pLQEfC6ma+5TJHyBmW/VesywtqGr9ZGMdtG4+5U=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4fub-0005cs-Rj; Thu, 01 Jun 2023 11:52:14 +0100
Message-ID: <24c9fb1e-bd5d-5ca0-a05b-f90cbedccab1@ilande.co.uk>
Date: Thu, 1 Jun 2023 11:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230530185949.410208-1-richard.henderson@linaro.org>
 <a2fd61cb-190b-9658-c6ef-0252679f1c5c@linaro.org>
 <d0c21bbb-0448-4539-beae-893ef120fca4@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <d0c21bbb-0448-4539-beae-893ef120fca4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 00/27] tcg patch queue
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/05/2023 17:12, Thomas Huth wrote:

> On 31/05/2023 03.08, Richard Henderson wrote:
>> On 5/30/23 11:59, Richard Henderson wrote:
>>> The following changes since commit 7fe6cb68117ac856e03c93d18aca09de015392b0:
>>>
>>>    Merge tag 'pull-target-arm-20230530-1' 
>>> ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2023-05-30 
>>> 08:02:05 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230530
>>>
>>> for you to fetch changes up to 276d77de503e8f5f5cbd3f7d94302ca12d1d982e:
>>>
>>>    tests/decode: Add tests for various named-field cases (2023-05-30 10:55:39 -0700)
>>>
>>> ----------------------------------------------------------------
>>> Improvements to 128-bit atomics:
>>>    - Separate __int128_t type and arithmetic detection
>>>    - Support 128-bit load/store in backend for i386, aarch64, ppc64, s390x
>>>    - Accelerate atomics via host/include/
>>> Decodetree:
>>>    - Add named field syntax
>>>    - Move tests to meson
>>
>> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.
> 
> Too bad that we've run out of CI minutes for the Windows jobs ... FYI, this is 
> causing now failure in the msys2 jobs:
> 
>   https://gitlab.com/thuth/qemu/-/jobs/4385862382#L4821
>   https://gitlab.com/thuth/qemu/-/jobs/4385862378#L4632

Given that we now run Kubernetes on Azure, should we consider setting up a Windows 
Kubernetes node for the msys2 jobs? When I last looked at this for a client ~2 years 
ago it was still experimental, but in theory it should be possible to set up a 
Windows node as part of the cluster and install the Windows GitLab runner in a 
container on it...


ATB,

Mark.


