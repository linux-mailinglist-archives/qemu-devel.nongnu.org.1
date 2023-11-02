Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D141A7DEC04
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 05:48:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyPbG-0000XD-2c; Thu, 02 Nov 2023 00:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leohou1402@gmail.com>)
 id 1qyPbE-0000Wt-M9
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 00:46:32 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leohou1402@gmail.com>)
 id 1qyPbC-0003Td-G3
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 00:46:32 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6c10f098a27so522492b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 21:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698900388; x=1699505188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgQi/LXnSgZer0xSlcrZQZbooc8iUiiCEGAwbSSf7dw=;
 b=ZYEly/JVvVWR87rNnx9mOzDrfaJMqrUDBsUZ5BwKXvAkfQLjCqON/q/KyxZ6UqITHF
 D6HCD2UHR6cMtQN6mQxJFzTSUU+5NYI5BLRVOoJGmCRpP8znwuBLf5CAPUb8hz4fo1Mu
 VV+jo/GP4jEa/9evwjYRVa49qIMuuxdN71t5ZIA52daw2Z+2HAVaBK6fv7eswwcV8DFr
 h1mNAY6h/fyubyQ7RV82pv0I0Rj8vAKmn7ef1kVe4LXrwwJZ0oSlOYTNwfTBhCXZ855O
 7fqbs7ufjHSSGC8uXAy2SI9YTlEIRih/DnjdliGzZ229/fGTf9gpVj1vcRgK3pRaf54E
 Tt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698900388; x=1699505188;
 h=content-transfer-encoding:in-reply-to:references:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XgQi/LXnSgZer0xSlcrZQZbooc8iUiiCEGAwbSSf7dw=;
 b=g0G7A7RRUcCFzwiAvFIG+P0k1A7GGbbrau0+Hoj0w5CiCLuttclCFMRzDCj+qXhc7P
 8QJZlwnx1J7u+5MfCgzYwzkmK4iszkgmVB8WhLI7S+mJ6viozuEfaJHOmtF44Ym1ozPo
 l6qKPmTNyNHEedpln1D2nG9kFJy1f8OVgEyGxArKSj/FgLjPWSFujwx1vDLF4fVSnzGi
 jpsuWU2EOgGGzzj0QwnhXCFcfQl4uHJVvxnGoKgk2rGfc4sddaamED5u8fG3Ud6Pv8wL
 cu9ywH5xSArDpjmamLZ+VA2HFmQC5lBY96p51p/CMVqCgEv8rWIVkDs1D5yyQUwCkc7o
 dD/Q==
X-Gm-Message-State: AOJu0YzNMwtQk90qtd6nSoOU9+2/vmg4TCp8oUutT3QwUbnEkaO+Z4yL
 W/57+Ygm5jTRdzOi7J2QWNeBr7P5XGYaNJ9t
X-Google-Smtp-Source: AGHT+IFfTrUHUhQIm7nLFP1Y4K5qN3fkCEB2JnzNjEToaacro5IvoiWd33jSbZC2N9X8kVrMJ+22vQ==
X-Received: by 2002:a05:6a21:7989:b0:180:d66b:7e7 with SMTP id
 bh9-20020a056a21798900b00180d66b07e7mr10234526pzc.4.1698900388592; 
 Wed, 01 Nov 2023 21:46:28 -0700 (PDT)
Received: from [10.100.201.23] ([40.83.119.27])
 by smtp.gmail.com with ESMTPSA id
 bf2-20020a170902b90200b001c5eb37e92csm2055663plb.305.2023.11.01.21.46.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 21:46:28 -0700 (PDT)
Message-ID: <0a514711-41cc-43ec-ba2d-16109eae783d@gmail.com>
Date: Thu, 2 Nov 2023 12:46:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogRnc6IOadpeiHqkxlbyBIb3XnmoTpgq7ku7Y=?=
From: leohou <leohou1402@gmail.com>
To: qemu-devel@nongnu.org
References: <3ab81ab1.1faf.18b8df8f26e.Coremail.leohou163@163.com>
 <202311021133346289459@gmail.com>
In-Reply-To: <202311021133346289459@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=leohou1402@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2023/11/2 11:33, leohou1402@gmail.com wrote:
> On 31/10/23 16:13:32 Philippe Mathieu-Daudé wrote:
>> Hi Leo,
>>
>> On 31/10/23 04:10, Leo Hou wrote:
>>> hi , all
>>>          Does qemu plan to support CPU heterogeneity?
>> Short answer is yes. When will this be available is yet to
>> be determined, as a lot of work is required.
>
>
>> I'm going to talk about the challenges and possible roadmap
>> later today, feel free to join the call scheduled at 2pm CET
>> on https://meet.jit.si/kvmcallmeeting.
>> (See
>> https://lore.kernel.org/qemu-devel/calendar-1ad16449-09cc-40fb-ab4a-24eafcc62d2a@google.com/)
>
> Hi Philippe
>
>
> Thank you for your reply. I didn't check my email in time
>   because of the mailbox problem. Now I will reply to you
>   by changing my email address.
>
> With regard to your discussion, is it convenient to announce
> the results of the discussion now?

Is there a need for the architecture of the main cpu and several 
coprocessors?



