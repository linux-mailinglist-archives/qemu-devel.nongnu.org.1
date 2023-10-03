Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66637B6B1F
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qng6t-0003Ng-6y; Tue, 03 Oct 2023 10:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qng6p-0003LS-NX
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:10:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qng6n-0003KM-AG
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:10:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8391F1F893;
 Tue,  3 Oct 2023 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696342242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePIuCji75qy8/LG19rMNh2y6FUN4q6I8uMl5nwwE/z8=;
 b=2QVbW8Eh8L6TpzftFAPNKs2cWFJ9MFqAe4gHW2Xu100zev3FgG2Axsdd0seCzPgyDgBP/6
 hcN8e0EMBY2ROEl8QNyXe2fz/3c4LupfPzTw7Opj9YaN5W4mpPIAGQLIVlo+4TMnndp+W1
 AHa8wm38R7YzgyX100ymzMEQu1Gh/XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696342242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePIuCji75qy8/LG19rMNh2y6FUN4q6I8uMl5nwwE/z8=;
 b=sAcDfgB+BJYxxc0kulu6uKsYxgFOwyD2ezDFJSZIMcJlOxm7EScxou/KVtVlbVCHw8IQOD
 dkScyQbyb1wq4MBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1935C139F9;
 Tue,  3 Oct 2023 14:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NWYEBOIgHGU0TAAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 03 Oct 2023 14:10:42 +0000
Message-ID: <b468e2cf-057c-08cf-3fc0-edb3709d0a11@suse.de>
Date: Tue, 3 Oct 2023 16:10:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/5] accel: Restrict tcg_exec_[un]realizefn() to TCG
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, kvm@vger.kernel.org,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230915190009.68404-1-philmd@linaro.org>
 <87e1be19-c1c6-73fb-3569-7dbf186662f7@linaro.org>
 <96a726c8-186c-3f09-9d9b-d17d7f5289e2@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <96a726c8-186c-3f09-9d9b-d17d7f5289e2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 10/3/23 16:04, Richard Henderson wrote:
> On 10/2/23 23:44, Philippe Mathieu-Daudé wrote:
>> On 15/9/23 21:00, Philippe Mathieu-Daudé wrote:
>>> - Add missing accel_cpu_unrealize()
>>> - Add AccelClass::[un]realize_cpu handlers
>>> - Use tcg_exec_[un]realizefn as AccelClass handlers
>>>
>>> Philippe Mathieu-Daudé (5):
>>>    accel: Rename accel_cpu_realizefn() ->  accel_cpu_realize()
>>>    accel: Introduce accel_cpu_unrealize() stub
>>>    accel: Declare AccelClass::[un]realize_cpu() handlers
>>>    accel/tcg: Have tcg_exec_realizefn() return a boolean
>>>    accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
>>
>> Ping?
>>
> 
> I have this series queued for the next tcg pull.
> 
> r~

I reviewed and tested the V2 if you want to queue that instead.

C

