Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775B78F675
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 02:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbsJ2-0004UT-57; Thu, 31 Aug 2023 20:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qbsIs-0004Tf-SU; Thu, 31 Aug 2023 20:46:27 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qbsIq-0006p5-8K; Thu, 31 Aug 2023 20:46:26 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68c3b9f83f4so1200363b3a.2; 
 Thu, 31 Aug 2023 17:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693529181; x=1694133981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nFvU/FMoSCyW0mf3xXRVHqnOLh+c1ISlntPyEgPuDz4=;
 b=WYTb0qxd7hsV30JegVE+osikefeFo5c6PI1pvFAOzoa0QDy1rKeqWWtEEuA0gamf/o
 hUl+1f9M2eoh6EjiRwilPrtCFhcqPtfatYN99wayvw7ajvsPD24eDChZIJNngXEAA1/v
 XXQRQtooD6Gx7fqCMieT5mYtCJrOoU9H3lK++k1W7zbSZJ8NhVcDO1bJMtHk7cQ+5QC7
 0G7Tx6JC+VPREfaM1qUYabreG/qXk9htdIjMf0yjv0n7uPCOfTmZKC1cbBGGh+SjV27Y
 LXu2nl+zm5IvG+xPVQDhbrwuiDDyYSObfpRMGFHXPMBpue8DnZOp7zbjsCToTbfIIg2A
 i3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693529181; x=1694133981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nFvU/FMoSCyW0mf3xXRVHqnOLh+c1ISlntPyEgPuDz4=;
 b=V3zHiXmxvIXxNrzQlO3lHPMtFYOGAdfIJlk6DOtj2GpeahC4miR+/krUabe4vU9uWx
 ZerYhdiNb4XYW4P/KNrZ/PKgP03j8p9zEABFlsJABzGMxCvO0MwneurDaRNfhg5rE72N
 j+NcYlvp4pT+vkLBqSpSgcVzVGqTasOh5X4BwxaTwSAWkA2ld4UkP3rb9htDN3O4R1qU
 O4/57o7w7WJUCuMSLkz/JdhNuh6imuQdH8NRCPDoL6GkCKX103GYKkX3llqXgxjtLZrP
 Q/PdWKgR5mL55Y7GV1BMGvWeEZUhV0cYRD6hEvUDai3rieKubf+KVK95XUG+JIm+epdH
 UhVw==
X-Gm-Message-State: AOJu0YzPOixyHw/lyc7bdTP3B27nVTIwDQitVc9j5sI7Lt09jzc4WiWI
 GAfm/l5Ge+9obeL0SyoAsuBtDd1C+PoYSA==
X-Google-Smtp-Source: AGHT+IF0mHwBKEcdSApS27hSqLbN5jADzVUiw9L1e3j0nSkKLTgSQkXrLtNv/wXUPYF2XDKjOzLVYg==
X-Received: by 2002:a05:6300:8082:b0:141:cc5f:7d28 with SMTP id
 ap2-20020a056300808200b00141cc5f7d28mr1257170pzc.50.1693529181123; 
 Thu, 31 Aug 2023 17:46:21 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 x52-20020a056a000bf400b006889348ba6esm1826019pfu.127.2023.08.31.17.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 17:46:20 -0700 (PDT)
Message-ID: <8a1713ac-8121-1ab6-9d9b-a772c2783161@gmail.com>
Date: Fri, 1 Sep 2023 09:46:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com,
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, stefanha@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 philmd@linaro.org, thuth@redhat.com, lvivier@redhat.com,
 jeuk20.kim@samsung.com
References: <cover.1691062912.git.jeuk20.kim@samsung.com>
 <CAJSP0QXnydKxy++mJmdt28gULER1grif0uZ-4xr+rpvv-zmuDw@mail.gmail.com>
Content-Language: en-US
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <CAJSP0QXnydKxy++mJmdt28gULER1grif0uZ-4xr+rpvv-zmuDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.478, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 23. 8. 30. 20:38, Stefan Hajnoczi wrote:
> On Thu, 3 Aug 2023 at 07:49, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
>> Dear Stefan,
>> I'm really sorry, but could you please put this patch series
>> instead of v8, which was previously merged into block-next?
>> The fixes from v8 are below.
>> Please let me know if you have any comments or issues.
> The CI hit a test failure:
> https://gitlab.com/qemu-project/qemu/-/jobs/4977256030
>
> Please investigate how to fix this so this series can be merged. Thanks!
>
> Stefan

https://gitlab.com/qemu-project/qemu/-/jobs/4977256030
https://gitlab.com/qemu-project/qemu/-/jobs/4977255992

I'll analyze and fix above issues and resend the patch.
Thanks for letting me know.

Jeuk


