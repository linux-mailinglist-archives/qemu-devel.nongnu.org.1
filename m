Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BB77F92C4
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 14:01:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Eji-0006sa-Ka; Sun, 26 Nov 2023 07:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r7Ejg-0006sL-D5
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 07:59:44 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <petrcvekcz@gmail.com>)
 id 1r7Eje-00014B-TA
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 07:59:44 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507c5249d55so5119237e87.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 04:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701003580; x=1701608380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FLi0SpP7WqgaMZFFAdvJpqkdh2j+byTwMwwVccc4dz0=;
 b=Tf9/M5N6wkTmZDAAswrfaoJLlW26PTZsqeSautmUdPs+poorAI6AH0m4BGuPgIPPjM
 eKA3gCV5uyOmTHpKnoA/t8hCcB9N7hzdnbT1HXo4MLDXW9AVkBCrDmMngcZQZlsvEVZr
 4EHES/pWcjtFHikQMNqqhMQjNpNgeXox6en14gIY7lj1nlP0WfIj9y/V1CBBqARm5oGc
 o2pSJeXy4cp26mogW3rKpQ5HS5mlQ1Jh4SKRVFRzXdzZ3DmwLV5CknJBgs7FfT+6GJ3o
 0dpl/UZ5/y5ELQdy4O9OgGpy9REJePvEExqwJozCgQpG1rswk20cdZqFtpVKorQt3yoH
 7ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701003580; x=1701608380;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FLi0SpP7WqgaMZFFAdvJpqkdh2j+byTwMwwVccc4dz0=;
 b=JauO9zknpvcoSDrNTTqGdJYkan8lyFvNeXt7M6rWEMRdjh+UBuNjqJASNHL+cmz3Nl
 lq8nTrLTQZgZJv3s3YNroahu6hSebAsK+59gG9q3CyckHOQ3y8ZlI2jeneIdQzb/vmQ5
 lZ0rwQiV2ZlQU9n5viX8Pl+W+jt4xM6IXpe2VQBEL8lT+huvfLEZp8PKxfvhBrI8DNgw
 3q8oQJdrXU2vM1hl3FixHIuseZOW51gFPz1/sQYMurRGhGryzNXjqJTuC2oqej2cB7HC
 BXAJShimEtkP+Ar1oPdesEejtp/L0X9tN0jlu7jVcpXeEzhYjLMEZe4BpvnFA5rB/+pu
 R2rg==
X-Gm-Message-State: AOJu0YxNTZZp4lT3xp09GyjylzUgzwN40ctuHfM+WplL7P/RPJDZyrLx
 NZwn/I90UvDNwR6ZuI9OEGA=
X-Google-Smtp-Source: AGHT+IEHwJgoP7MmEIGutTj02R6+L41NvEQA0p6ccuZzyI0DGBiKbM3N8UVzQKJrawKqE+O5PzYI2w==
X-Received: by 2002:a19:6415:0:b0:504:4165:54ab with SMTP id
 y21-20020a196415000000b00504416554abmr4497955lfb.56.1701003580116; 
 Sun, 26 Nov 2023 04:59:40 -0800 (PST)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab?
 (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz.
 [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05600c34c500b0040b349c91acsm11033486wmq.16.2023.11.26.04.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 04:59:39 -0800 (PST)
Message-ID: <3380b626-0d94-489f-bf98-6146c1420a51@gmail.com>
Date: Sun, 26 Nov 2023 13:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
To: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
Cc: pbonzini@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 qemu-devel@nongnu.org
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
 <87msv065vx.fsf@telecom-paris.fr>
Content-Language: en-US, cs
From: Petr Cvek <petrcvekcz@gmail.com>
In-Reply-To: <87msv065vx.fsf@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=petrcvekcz@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Actually I was thinking about mentioning it in the commit message also, but I wasn't able
to find any specification for that (if all compilers use it).

Other problem is the __tune_i386__ is also set when -mtune=i386 (but with -march=i686).

But if the general idea of changing the code for 486 is OK it can be added also.

Petr

Dne 26. 11. 23 v 13:37 Samuel Tardieu napsal(a):
> 
> Petr Cvek <petrcvekcz@gmail.com> writes:
> 
>> GCC defines __i386__ for i386 and i486, which both lack RDTSC instruction.
>> The i386 seems to be impossible to distinguish, but i486 can be identified
>> by checking for undefined __i486__.
> 
> Couldn't you check for an undefined __tune_i386__, which would be set by both GCC and LLVM when using -march=i386.
> 
>  Sam

