Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 386AA72AEDB
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 22:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q85UU-0003nr-Em; Sat, 10 Jun 2023 16:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q85UR-0003nf-8V
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 16:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q85UP-0003US-Nu
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 16:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686430031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbKmhtEhkeDJBNNqGAX3gApQFu3cdUtYSjue5zfYxFo=;
 b=MPpq4rVoROJMmX63LC6F6g0T78nFrhFMmrsHUqiwS6ziH2G5+GxglFDhYSzKCH0PFRPrHz
 Laay4ul5y0R9B/H3uXDQ6n9GbzK5NHH3VmhMARk+GKb/Q+UvGdg1/K7cpT0heGPw5ct/jr
 t+LqxSuQv+D/c8PfBtgD/PPylKma764=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-qHQOlh5WPpukfRuHlyv0RA-1; Sat, 10 Jun 2023 16:47:10 -0400
X-MC-Unique: qHQOlh5WPpukfRuHlyv0RA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-975942c2a29so264479666b.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 13:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686430029; x=1689022029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UbKmhtEhkeDJBNNqGAX3gApQFu3cdUtYSjue5zfYxFo=;
 b=bfyLk3DN2re+I9Q4F9xTvTyC2fDUwd5mFFKK/McWs8oTkZcRXKoVv5Jj5seScVoGCo
 ELu/UlgcDvIPLeGKTbPJieCMJOFJy3Qj26T9E/eq/GGVvD/ux3ALt2zrcykYWW2Sn/5x
 Bg2vKYz8sXPiOLrE6HPH0kzhmnbWQI2USm73d/OtsCXMQmzwx7bCOC2jTRLPQvR+CdMk
 r2Jiup4+19YZFx416/WLbXsKt154jggFp8QJdId8EUKYI4BhjjrUR1lc1Ven748fN9fb
 NQy+2dHWg+CYeQnGSvKN+TdnwEANgzU40jpWlDkug8yPvIKPHaYYjQYYD0RhWte+fQ9A
 O+Jw==
X-Gm-Message-State: AC+VfDzkMMFg3EQ0r717DqyZurUYWd6SkZWoKiQjDBGfFaBRRKM+qq4j
 GpoLmAAZbtq0f8AmxyiGqe43PmsgA5ivN3W1EgsoXbr/hmfRjnhvSroRfghf5KmvMvjabq54o5o
 Cw7koqfvwzEp5omU=
X-Received: by 2002:a17:907:3203:b0:966:5c04:2c61 with SMTP id
 xg3-20020a170907320300b009665c042c61mr4203351ejb.8.1686430029118; 
 Sat, 10 Jun 2023 13:47:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XW7O8DcB6dMoEKVzY1B1ySTJ3ePGmvwFbSDdj/V5hrvVO6iYc7hEkdEvCfZqMMCYPfndXMA==
X-Received: by 2002:a17:907:3203:b0:966:5c04:2c61 with SMTP id
 xg3-20020a170907320300b009665c042c61mr4203338ejb.8.1686430028884; 
 Sat, 10 Jun 2023 13:47:08 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 kg1-20020a17090776e100b00977da5d3350sm2922306ejc.107.2023.06.10.13.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 13:47:08 -0700 (PDT)
Message-ID: <bb00bfd3-b483-badb-0331-d2d3f6d21b53@redhat.com>
Date: Sat, 10 Jun 2023 22:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] machine: do not crash if default RAM backend name has
 been stollen
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, wangyanan55@huawei.com
References: <20230522131717.3780533-1-imammedo@redhat.com>
 <20230609160625.3cb92853@imammedo.users.ipa.redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230609160625.3cb92853@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 09/06/2023 16.06, Igor Mammedov wrote:
> On Mon, 22 May 2023 15:17:17 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> Paolo,
> can you pick it up?

It's merged already (commit a37531f2381c4e294e48b14170894741283)

  Cheers,
   Thomas


