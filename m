Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F0CID22b2nHMAAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 18:07:09 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535BA4843D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 18:07:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viBHK-0000kr-CT; Tue, 20 Jan 2026 07:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viBHE-0000dm-VK
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:56:10 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viBHB-0005K5-KB
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:56:07 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64471fcdef0so4307379d50.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 04:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768913764; cv=none;
 d=google.com; s=arc-20240605;
 b=MwzjM3VodxuciU8wLKjSpT9HOK6qGxEQQoSFoIOFG94yjqQhMrEvtFQjwGYr8lKgtN
 Yme3HkdeT+PtMUbMMVUBNXECU9s4ZzTERxCtnZJgoE4Amy6FEGdXsiNveeMUIoBz1f2Z
 W/E3Ti1gCMvIvpOIzsqpLaiOuRk4MIB4m7hMAbgvxC38ZuM/DqJeN2rOUb1N7q4/+NLh
 YT+SywFmDbKhgBRjSaXKOD4pPrJy7L6V/2wR+Y+3mDU8/RqyvWa6uag6L89a03TqnlBG
 QYsUbtBE3hoYqqPgUbtLBMwl79WJTlTx5xOSryEcpYe0o6uzVcyfbbOOPB6h9vRU856j
 nUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=omFAiSpJLZYPxf7ZDkfiMVG/PJNHvB899Uos2656+38=;
 fh=/7s1nUSA0frF4G90NEoYZzdIY7SE2U2MgJpwf+NOgAg=;
 b=lzENqRD905m8ejHXU/JC8zra1zYXp279yGWyUeLRNwXCCFpnMFXI4GuEYBqG4ZJV6L
 zmhOufHSQM5QBa3i+R5mLrrDzFjlGu6r/mzaBBRK/wr/j8pKLuJyOTaVUKVoL0cziOqy
 y93Xjpwh4J98y41X1yocK7FmTETTBVhHtdx6EcJdU9Tkwq2RtU7+L+S2aiGFv+FFmfu/
 geE3oNAb/Mu6rmODbEfymjA9C0OHFVhCaUwdXupGO4NjU2RQRsdW7QgbZWTMLg8HNzVD
 cPWr+eP/NyfylpA6IoEyRQXNm9TXNFCGFPq/vd0fPtZcIM6iI1xrRUDVU8fzHz5lXYEV
 RRVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768913764; x=1769518564; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=omFAiSpJLZYPxf7ZDkfiMVG/PJNHvB899Uos2656+38=;
 b=EoPSYAluTIvBwhAxYIjEU21skSdIJyyJMjWrG9h6f6vZydP0kmNEayP66tR1N7gTg9
 D+sZDiQq5ZK4zLXxTtqSK/gQr8ZOqATb04IB1APmZgycjThb22Oa2RF7iI2vG5dC7TRL
 CWy5JZQpNQP3XwKHTWHuImArLP3j/a90FNI91ZZR8VkwJdnUM67w11NEDgDF4/0a85cE
 DF9A5tUUYumtdgTPIqRVHkW5NMmi7JjbXbwBHJ5iCklpK3u5PPCWc7dBm+6xuDfZlP0O
 NI7wSoAdus4XBdTx3ZQA+tOh2Fq+eqqbEqY4o9bQFsQKJKvWKKV3CrmnKu2Mq1mzqvzz
 9njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768913764; x=1769518564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omFAiSpJLZYPxf7ZDkfiMVG/PJNHvB899Uos2656+38=;
 b=JME1fZ0YZEXtk5Kne2NF1TyQdPWRnQsydtLVruIQ1DBBTdHO3dvWiPzWdT9dJWU8Jw
 0X3/EB6LA4Y1n02NIygtdc6IENT5P2xcTgQhKL/6tRW+CUa9YndVxCv4BW8C6bLwxz00
 IFfVGo4b++wzBoeAWwKz/8n0zXlRuGcJjJg3sAecV+QJCHcvZMJkjaif7gyBXBfyf38m
 iRgzPjOJAXCHASlryDKUh2aj+1tMeOMV4dfsfurK4D7vPmfC4vAA6uF/ppzjbNN+VIlG
 NSnOkPrKAryR4SUMrEGXCVpRUnLRzN+uoS7BeTa3Q+XHUUq4p8nNWKukLdQnUP5/dUGy
 Gxbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq3/cFrIn4KvjkuWtZbUzMvBfhWfj8cyJeuoxXF3w99MaStcf48d3TetU2/0fkSLZxAJlaxd2uRaYp@nongnu.org
X-Gm-Message-State: AOJu0Yy5XzzaOSfj0DL51PB31ziXeYdrCIbzdt1xZ/KSuLNv1J8PnGUU
 hswzdqcI/sOW/89R4E++NFPAyO/B62cX5z+XhQ2/0TIctm0bjTY+ZiZdSRl2k6luDDu1wfs6CIt
 N2bXqsc7O065xa11nLEOL0A/Ddo36ehxNeBgqaeuNBA==
X-Gm-Gg: AZuq6aLa7FBmLk0ofBN0iR0rlZmmcNSUdGW1rm/eacemUS5zhY9HJeP5umH4FOjrjXE
 TEgTeE/594wPm3QzcZVShE43D/msGCV2maTt3cU4/OiUa4Qw81ZctGYo3J/LkIOlIPla2U+3SnK
 3I5jEJF9Z/MoXvjwJzt37s2qjHjINcONyA3/L0a8CU3biCahzA6ThOdUpPTq3aqJPo8rMB/xrrb
 SJKmXn8WKaAUEidAD8tpmBgf87iDln+1JPBwiOHMgK/Z9C9j3BC4bdULuvrSrmgJF7jmw==
X-Received: by 2002:a05:690c:6209:b0:794:87a:fba7 with SMTP id
 00721157ae682-7940a116c60mr27517467b3.15.1768913763845; Tue, 20 Jan 2026
 04:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20260120122108.131708-1-thuth@redhat.com>
In-Reply-To: <20260120122108.131708-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jan 2026 12:55:52 +0000
X-Gm-Features: AZwV_Qi_7BWL_eeKJtOqa4gmPfLmIXZu54cyVs9q_xAA5vB3G8FokRs4ACT2dVo
Message-ID: <CAFEAcA8nzm+CEN_Dp+X+AggcTg57wAt8D43x-7oixLeNH4TDdA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Move the "arm-cpu" compat settings out of
 hw/core/machine.c
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-0.71 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	MAILLIST(-0.20)[mailman];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thuth@redhat.com,m:philmd@linaro.org,m:wangyanan55@huawei.com,m:zhao1.liu@intel.com,m:qemu-arm@nongnu.org,m:eduardo@habkost.net,m:marcel.apfelbaum@gmail.com,m:qemu-devel@nongnu.org,m:marcelapfelbaum@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[qemu-devel@nongnu.org];
	FORGED_SENDER(0.00)[peter.maydell@linaro.org,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.maydell@linaro.org,qemu-devel-bounces@nongnu.org];
	FREEMAIL_CC(0.00)[linaro.org,huawei.com,intel.com,nongnu.org,habkost.net,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	TAGGED_RCPT(0.00)[qemu-devel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,lists.gnu.org:rdns,lists.gnu.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 535BA4843D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 at 12:21, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> The hw_compat_* arrays in hw/core/machine.c should be used for generic
> compat settings that might affect all (or at least multiple) machines.
> Target specific settings should rather go into the target specific
> source files instead. For arm/aarch64, the virt machine is the only
> one that cares about compat settings, so move the "arm-cpu" related
> switches to hw/arm/virt.c now.

I think it makes more sense for all the compat stuff to
live in one place, rather than being scattered around,
unless it is truly machine-specific (which this isn't).
The hw/core arrays seem to be where we put compat
props which are related to a particular device rather
than a specific machine.

thanks
-- PMM

