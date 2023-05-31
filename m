Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A1718723
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:15:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4OSQ-0006h2-GS; Wed, 31 May 2023 12:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ORZ-0006UN-0h
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ORO-000172-TF
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685549566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zgxupfJVM49EWzcz406UgK9SUb0t90kmFdlOVXcnu4c=;
 b=H+uyNENTiASQVCFtC9/qdD/fmKRvd+5J5bBhlgpBmmQfCClcyWpNXhzF0amfLBgkcAOJz+
 AVSZTWj5WBpbnIODEsgUXUaYo3oJWVw5trizbfniTOrkSPTrbZMN4afUuvbPjjQRZSD124
 xNO5J7htmMPGObpcELYAliZCmjoTFPE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-Qq0xW_0cMEucmVUaTCcwyA-1; Wed, 31 May 2023 12:12:45 -0400
X-MC-Unique: Qq0xW_0cMEucmVUaTCcwyA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f6ffc45209so6035675e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 09:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685549564; x=1688141564;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zgxupfJVM49EWzcz406UgK9SUb0t90kmFdlOVXcnu4c=;
 b=IXjcSJMOgy6kB5KoKN9mNDlvUnP32c8qqtieIat8bTBTfzp2rInb6vqfeoGP1sLwhh
 mexfW64UJ7l8C+Vvib+uNMAyLWA2CPx9Tk0nDPauEvdWzJC4cB/pjpmButS0m3kpx3cv
 A2PhhdEYavTECdIa5Mj94kbMpL9A6SW2aDrr+ZXK3FFtYscdYSFCwt8YRgHdWsFvSw/v
 NOB0vaCas6vfZ7Nu19Go8bghG7E4EYS9ZeEOz2dkg6u6qHRPFA0Ptc7oM4mEH45ApKAW
 pVzqDSjiWNjJq+JCr2ZBxnz2TJFYBOZvAHzKb+OEWjGkWU0iMQKr3w6duUige17FBYh8
 mFeQ==
X-Gm-Message-State: AC+VfDyucjtr7XK1VUuZc8FT69xpV22rGO9hjHsGuPbtDhdoJMaIEKhx
 UTK/daa2uKf9waMsBPRbhz6ojErEKCe6B7umFVJzJeMzbuTdq96S9MWud4sg97qb/BFx6ujj0qg
 SXlQvYUWMqaA+8paZ/bUdsxQ=
X-Received: by 2002:a05:600c:35c8:b0:3f7:174b:bdbd with SMTP id
 r8-20020a05600c35c800b003f7174bbdbdmr1742086wmq.5.1685549564046; 
 Wed, 31 May 2023 09:12:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ODviv1Z1Vv5ushKqQ76Bzs+ubhIaCjKhGm4bc/QwyyHFir6QjicHGeJjROzzduyXmyL7zKg==
X-Received: by 2002:a05:600c:35c8:b0:3f7:174b:bdbd with SMTP id
 r8-20020a05600c35c800b003f7174bbdbdmr1742074wmq.5.1685549563740; 
 Wed, 31 May 2023 09:12:43 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-4.web.vodafone.de. [109.43.178.4])
 by smtp.gmail.com with ESMTPSA id
 n13-20020adfe78d000000b003078681a1e8sm7276173wrm.54.2023.05.31.09.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 09:12:43 -0700 (PDT)
Message-ID: <d0c21bbb-0448-4539-beae-893ef120fca4@redhat.com>
Date: Wed, 31 May 2023 18:12:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/27] tcg patch queue
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230530185949.410208-1-richard.henderson@linaro.org>
 <a2fd61cb-190b-9658-c6ef-0252679f1c5c@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <a2fd61cb-190b-9658-c6ef-0252679f1c5c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/05/2023 03.08, Richard Henderson wrote:
> On 5/30/23 11:59, Richard Henderson wrote:
>> The following changes since commit 7fe6cb68117ac856e03c93d18aca09de015392b0:
>>
>>    Merge tag 'pull-target-arm-20230530-1' 
>> ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging 
>> (2023-05-30 08:02:05 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20230530
>>
>> for you to fetch changes up to 276d77de503e8f5f5cbd3f7d94302ca12d1d982e:
>>
>>    tests/decode: Add tests for various named-field cases (2023-05-30 
>> 10:55:39 -0700)
>>
>> ----------------------------------------------------------------
>> Improvements to 128-bit atomics:
>>    - Separate __int128_t type and arithmetic detection
>>    - Support 128-bit load/store in backend for i386, aarch64, ppc64, s390x
>>    - Accelerate atomics via host/include/
>> Decodetree:
>>    - Add named field syntax
>>    - Move tests to meson
> 
> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as 
> appropriate.

Too bad that we've run out of CI minutes for the Windows jobs ... FYI, this 
is causing now failure in the msys2 jobs:

  https://gitlab.com/thuth/qemu/-/jobs/4385862382#L4821
  https://gitlab.com/thuth/qemu/-/jobs/4385862378#L4632

  Thomas



