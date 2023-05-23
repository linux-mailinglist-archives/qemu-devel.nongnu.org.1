Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 918CC70DD2E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Rj7-0005GW-Cr; Tue, 23 May 2023 09:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Rj1-0005Dy-Tp
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1Rj0-00015z-C2
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684847209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9W/GIgR7kGLCJkifjU2EPZiulltikRRfmQYeSA/RXLg=;
 b=NvdPnNZw+gXVkQWMeDm5kxW1PIDvVkoDKyXeAIBDPvu2Q1QAZs6fzDaV9uazh+o53ZIVJh
 4y7SV1LCKLyY/ErkeLwMappE+WIh5Z0ooK2cCDZ1B6wMfGJ2sty8DGv9gpSxbF6OFtw2R1
 7v3RENIHzqsKkMdTz/C4OAcytVV9o0I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-Y0dDt40XMtOFP5fCXRw9iQ-1; Tue, 23 May 2023 09:06:45 -0400
X-MC-Unique: Y0dDt40XMtOFP5fCXRw9iQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3093e600770so4707433f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684847204; x=1687439204;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9W/GIgR7kGLCJkifjU2EPZiulltikRRfmQYeSA/RXLg=;
 b=WSa68S9E/NynoJbw5PDRSmUqQNMmxKnMT3TKgHQdp2OyHyuSQwSsKw+tQmsUrYAZIx
 NIFB8KSoDyihkbJXrRjFgBaF82ebj0gJtnj6z6JpLyNzlyX0A4L26T4Q2o197d33o9aA
 NUGIZzNk1Hb0hrbh5UtDMH9oBRgaRipYcZjYHMmRPOLyZMkw55K3W3fkGrBe5HI6rnIZ
 Z48Azsxgf5frlBZg9NlDefFgtz88jMaENkCbnkt7y1G3hU4Pahc9+ifgIXUHFenE7C0T
 kitMmICF14w7gWumHAvG/PaLH73yaPx+8+owdAZw/0MfDJKY8/RyyEKL2ZWVG8J3nR27
 Vdng==
X-Gm-Message-State: AC+VfDxgmfCRR8Vf80Jj4H0FO68KOg1SmcAhJBVjBTmfLF/mCyXFA9KD
 b+7fNv/SmybvQPYJYC9c3QodObcQcsj/+cHk/9AjWqJcoonfcbgJvS0mt37TsFwOSssSIFcZGrA
 ZlXck8GVgH2Mwh6E=
X-Received: by 2002:adf:eacf:0:b0:307:2d0c:4036 with SMTP id
 o15-20020adfeacf000000b003072d0c4036mr11599581wrn.66.1684847204019; 
 Tue, 23 May 2023 06:06:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kpif3d+dgdiYhVpSQrTvB3B+Ygmud+fPFXmc60Lvcd2zAYlI3w2Qna3vgLx2uxBzje5Y0ng==
X-Received: by 2002:adf:eacf:0:b0:307:2d0c:4036 with SMTP id
 o15-20020adfeacf000000b003072d0c4036mr11599566wrn.66.1684847203730; 
 Tue, 23 May 2023 06:06:43 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 r14-20020adfce8e000000b00306c5900c10sm11170502wrn.9.2023.05.23.06.06.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:06:43 -0700 (PDT)
Message-ID: <0d4d72b3-4b21-d371-7d15-bb36b33bbbc4@redhat.com>
Date: Tue, 23 May 2023 15:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: The madness of ad hoc special IDs (was: [PATCH] machine: do not
 crash if default RAM backend name has been stollen)
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, wangyanan55@huawei.com,
 pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230522131717.3780533-1-imammedo@redhat.com>
 <877csz6xgd.fsf@pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <877csz6xgd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 23/05/2023 14.31, Markus Armbruster wrote:
...
> To stop creating more moles, we need to reserve IDs for the system's
> use, and let the system pick only reserved IDs going forward.

Just something to add here: We already have a function for generating 
internal IDs, the id_generate() function in util/id.c ... our convention is 
that we use "#" as prefix for those, so for new code (which is not affected 
by migration backward compatibility problems), we should maybe take care of 
always using that prefix for internal IDs, too.

  Thomas



