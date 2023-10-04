Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6856A7B7634
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 03:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnqXC-0007JP-QF; Tue, 03 Oct 2023 21:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qnqXA-0007Ie-Jp; Tue, 03 Oct 2023 21:18:40 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qnqX8-0008Gs-Sr; Tue, 03 Oct 2023 21:18:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-692d2e8c003so312986b3a.1; 
 Tue, 03 Oct 2023 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696382316; x=1696987116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HyxfaqGgkRcPiRoLdZZNv0gu1nno4tpupQiR3QDVq0w=;
 b=ekJAnLERPmktpuo47iKql8EIZx7ge/V+CwGmQDuukp5gd/vMYxhCbPBgjVAwrZNUll
 P4XT/q9e7fGuld48SIVQ6hojpvnubQ660mVXW5yYAyxRu1tg5GoZL7RT56ixMtEiD1J2
 h7kStB+SMVp1WN3zP1WDi2YHR0VBuWAgGw2Phcl8qurx8lkLo9uuXzoDyBoLV7vOgWbc
 LA1bZ3p02FcExaAsEExxc3koeWeKwf+3NCJC6bgANL837beKhq8e3aV3wIY0HRJh1iE3
 kGllsl/EUBkXocBK8oqffZ6DELidtlltCLNGatMVreiZUPdHjCvrKY5jVvx5NQ8qJRpL
 aKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696382316; x=1696987116;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HyxfaqGgkRcPiRoLdZZNv0gu1nno4tpupQiR3QDVq0w=;
 b=GAZNY1hbrV0Abg2VtvNqd9trQOj8Em8+SKE1SWftAbB86EmQvbBbq3+RuoOrbM5YiS
 fDys4AtMVogLqaooh1XnjSrRLp/N+cj0YrTcK//saHJIftWIRZjNG2anBbp4621imz5w
 xqs+PCz/y4Yc/uB+FQXoziAhb8q7dWZrj26+wa91jO4gQmDD5amCpu3JnavnwnwpjBql
 k+DCqv1TRdTSR5/VQi25Ho0WOqiZeBls7Y7AmxkWE2OOyItrspCg9006rW9rZcXTOG5x
 VhTuHfydVUO3YGKc1HlpyWgCWw38Ce5bSRhfyJ5lTMuuL2bbUelq6CwTP3C1/yshOgM0
 3d4A==
X-Gm-Message-State: AOJu0Yy+6K5+CPQ5fY3DBMZkk8LH0y6K2B5jUmkyAH3MytuGdhHFXdpE
 UVUfzZtMWDoreRMp6hJdXx8yjezFq7H9cw==
X-Google-Smtp-Source: AGHT+IE2UTj913Ju0iijK5bTFLAyC4PrCG5jO9jVJMIAVuqKeffhUZScdd4yTQpHwBjb+b9ynPjvNA==
X-Received: by 2002:a05:6a21:9993:b0:14e:2208:d62f with SMTP id
 ve19-20020a056a21999300b0014e2208d62fmr1418827pzb.22.1696382316531; 
 Tue, 03 Oct 2023 18:18:36 -0700 (PDT)
Received: from [192.168.0.62] ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 a13-20020aa7864d000000b00690cd49cee2sm2012714pfo.63.2023.10.03.18.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 18:18:36 -0700 (PDT)
Message-ID: <4642df53-6f67-c66a-4b22-270b3158b6fe@gmail.com>
Date: Wed, 4 Oct 2023 10:18:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Ping: Re: [PULL 4/5] hw/ufs: Support for UFS logical unit
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-5-stefanha@redhat.com>
 <c4dc2292-4690-f16f-4b70-d6f759c16633@redhat.com>
 <160581dc-bdbc-03e8-64a5-1adb818a15b2@gmail.com>
 <86ebcc33-491c-8820-2ca0-51d46b0b7375@redhat.com>
 <9a8f1e6e-edcf-416d-9508-8af666db4263@gmail.com>
Content-Language: en-US
In-Reply-To: <9a8f1e6e-edcf-416d-9508-8af666db4263@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Dear Paolo

This is a ping for the following.
If you don't mind, could you give me some feedback?
Thank you very much.

Jeuk


On 23. 9. 21. 17:38, Jeuk Kim wrote:
> Dear Paolo
>
> Hi. I've been looking into how ufs-lu can share code with scsi-hd.
>
> I have verified that ufs-lu can use scsi-hd's code, and I would like 
> to modify it to do so.
>
> I've validated two possible fixes.
> I'd like to hear your thoughts.
>
> Option1.
> As you mentioned, using ufsbus, which inherits from scsibus, removes 
> the ufs-lu device type and use scsi-hd. (like -device ufs,id=ufs0 
> -device scsi-hd,bus=ufs0)
> I've verified that this method is implementable, except for one problem.
> Because we are using the scsi-hd type instead of the ufs-lu type, the 
> ufs has to manage all the ufs-lu specific data (such as the unit 
> descriptor).
> However, since there is no ufs_lu_realize() function, we need a way to 
> notify the ufs when a new scsi-hd device is added.
> Would there be a way to let the ufs know that a new scsi-hd has been 
> added at scsi_hd_realize() time?
>
> Option 2.
> Use qdev_new() & qdev_realize() to make ufs-lu have a virtual scsi bus 
> and scsi-hd.
> The ufs-lu can pass through SCSI commands to the virtual scsi-hd.
> This is similar to the method used by the device "usb-storage".
>
> With this method, I can keep the ufs-lu device type (ufs_lu_realize() 
> makes it convenient to manage ufs-lu related data) and avoid 
> duplicating code with scsi-hd.
> So I prefer this approach, but the annotation for "usb-storage" is 
> marked with a "Hack alert", so I'm not sure if this is the right way.
> The code can be found in usb_msd_storage_realize() 
> (hw/usb/dev-storage-classic.c:51).
>
> I am wondering if you could give me some advice on this and your 
> preferred direction for fixing it.
>
> Thank you so much.
>
> Jeuk
>

