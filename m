Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 438FA7F96A1
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:51:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7OuG-00011x-Af; Sun, 26 Nov 2023 18:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Ou9-0000yB-Qk
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:51:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Ou8-0003r6-7l
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701042671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pr+A82e750c5TgcxUv3ChGYDntJzvYRbOWfTYLKSo6w=;
 b=L9pjUN2D8443bbT1b1WrTS5PkUvfZQK4x9YV9QRrN077P4V92Idu1qbmh8fdC7k2lcLtNB
 yW6yZQZv1/IRlDEsphmVsvW0ZZLjt86KbW2O7H4PAnpgmbBaz0R3Sw8DVmxKtKYth+JWYr
 GfDJZdTqoV49DyERNrAYejeqZsEVY58=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-dcq8UU9lN_qdPLJz0VOeiw-1; Sun, 26 Nov 2023 18:51:09 -0500
X-MC-Unique: dcq8UU9lN_qdPLJz0VOeiw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2858cb6b1a8so3222860a91.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701042668; x=1701647468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pr+A82e750c5TgcxUv3ChGYDntJzvYRbOWfTYLKSo6w=;
 b=bVYOvdbVByaCFcG5oJvBCFRHNrcDZ1W9Ezc7ci4FX9vvXEC2IuQygbYSgxtyRUp1Ji
 fDTk8h5zb2OpKf+463AwWht7uEAspGHBs8fzCh3biM0ZP7v4n+Mnu+5Fb1w+HRykiTrG
 u9F0pFwLKM8x6VRtp0uJhWG6Av5cbfiz/YodAo+lyYI2VbHsdMc6TpAS/IC7jpMur0HM
 xz1ldIUhMUfGl5xE2UCsKlxr0pOUuJe2zOLSpnD2PTTASN1UheZ3GZmysSrsCiz/79AI
 8jvZQTE9ILNKqm++Gg/GpwTkg5+oW/h6NIy686rCP14DlLvXLPzTzFVWuAQfrO3vGn6o
 daPw==
X-Gm-Message-State: AOJu0Yy/LWxmd47FuciFBdFB0nnamVyhiPaOg2T7ACErcSti+ZuA28UE
 PmfX+lmYsT5KjIgI5Mwv1DGuJa3mWKeYWijKASbiJIR9obZq6JnlS0PSLDDQA1HMuXuGrsZ8DL7
 wC+ps/t0XtIb59zU=
X-Received: by 2002:a17:90b:4c91:b0:285:bd52:32df with SMTP id
 my17-20020a17090b4c9100b00285bd5232dfmr1696913pjb.30.1701042668448; 
 Sun, 26 Nov 2023 15:51:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWgBv/3pYREeYOff+4jYiCEicayRt/LFFhD/LsYmoV1r9tyxFsr5v4t4f1PGZcHGTvROFe7Q==
X-Received: by 2002:a17:90b:4c91:b0:285:bd52:32df with SMTP id
 my17-20020a17090b4c9100b00285bd5232dfmr1696907pjb.30.1701042668192; 
 Sun, 26 Nov 2023 15:51:08 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 fw13-20020a17090b128d00b002839d7d8bf3sm4723550pjb.55.2023.11.26.15.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:51:07 -0800 (PST)
Message-ID: <356fd7b1-4a0e-47d3-8efb-c919965a09b2@redhat.com>
Date: Mon, 27 Nov 2023 10:51:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/21] target/arm/kvm: Move kvm_arm_hw_debug_active and
 unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-7-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/23/23 15:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  8 --------
>   target/arm/kvm.c     | 11 +++++++++++
>   target/arm/kvm64.c   |  5 -----
>   3 files changed, 11 insertions(+), 13 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


