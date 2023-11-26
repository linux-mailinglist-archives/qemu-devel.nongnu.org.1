Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1000A7F9691
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:38:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Ofx-0004IY-6A; Sun, 26 Nov 2023 18:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Ofo-0004Fq-CH
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7Ofg-0001WW-He
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701041768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZu0i87548G2mYL235eTaRtByfSrsrcgVwdDlySrJV4=;
 b=PV3eLPjzBgRvvGVfhmSq7Iu1iLi2X8ihBRFlx/oyVv6NbVOp5O1WTklhE0tpB79DX2FPzG
 eWouWLZdz5J2ouU/j5YQSdB6D7EoSflo2/l4SfettKlAkE5HJ/OS1xSzVCCL0Pe+vfOjr2
 nb4IgQ40rSH0sfTf2RA+Ye/pyxOnDs8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-dnZyaPDCMTehLFU6BwD4Lw-1; Sun, 26 Nov 2023 18:36:07 -0500
X-MC-Unique: dnZyaPDCMTehLFU6BwD4Lw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1cfb96854daso19087715ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701041766; x=1701646566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pZu0i87548G2mYL235eTaRtByfSrsrcgVwdDlySrJV4=;
 b=hYyLQ+mFuQCx2Dc/uOMk4czpYD+3sDdibhwSX0P4LsxohEGsU3sBtlXjDoR8qiLomP
 5kd1m4HgVDY9JLTl4FA6/aZBsex/v8zZ4xunoHoj2Yl4JSyduaVur8em7INeTavZIsWv
 55yW64sIqlRcW4ObjNkYCoEnaXi/2OhdO2bGRIXZOZimo5vj+77PlHccsiluZMLx/aat
 JHnYVCkerkBJKUsPE3CMYvbBqEyVWaiLjCsuAEjWG46p5StJRNC8crUBJI9ystg6Iuef
 xH50ZoBgKBl1QP1CJPtD6tnYFNdqJyn5dx8vJ+fGtFjoZVgZZIHFs6gi3wRs0u54ejTI
 O1yw==
X-Gm-Message-State: AOJu0YyJMVkM7b9sE4Nml0VF/2plleK0+6/EdI66F/h+gfydP49r+r8Z
 J65boXKMxTbKRIPVGw2nKWcd55AIyAIa3POxrCpPUsCaMQvhoC+VZw+m76X/n8cZhvfB8ls0zJ8
 Q5kw8WUfBWWs6EXs=
X-Received: by 2002:a17:902:d88b:b0:1cf:7666:4dd0 with SMTP id
 b11-20020a170902d88b00b001cf76664dd0mr10437874plz.39.1701041766154; 
 Sun, 26 Nov 2023 15:36:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcHdwm0OpYlQt39lJ64oVIPmP9EA7hwEsktrcuLFYmaHn5Q2R/0lYkMHlcMt+DEKulsRInHw==
X-Received: by 2002:a17:902:d88b:b0:1cf:7666:4dd0 with SMTP id
 b11-20020a170902d88b00b001cf76664dd0mr10437858plz.39.1701041765850; 
 Sun, 26 Nov 2023 15:36:05 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a17090282c700b001c5f77e23a8sm6849908plz.73.2023.11.26.15.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:36:05 -0800 (PST)
Message-ID: <4a9bb2a7-cbb9-4fcc-b608-3779084fcb62@redhat.com>
Date: Mon, 27 Nov 2023 10:36:01 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] accel/kvm: Make kvm_has_guest_debug static
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-2-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-2-richard.henderson@linaro.org>
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

On 11/23/23 15:41, Richard Henderson wrote:
> This variable is not used or declared outside kvm-all.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


