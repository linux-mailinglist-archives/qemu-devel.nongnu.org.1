Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C77A17E4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 10:00:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3jd-0002Qe-0L; Fri, 15 Sep 2023 03:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qh3jW-0002Nh-HO
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qh3jQ-0004mq-Vf
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694764754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5UjlkA4DOtAXo0rFo2CE+9Oxuoa+is6gY8rdTXhXp4=;
 b=GpMmnbyEZlA9mHkwGI01CM5XHzQ5nEKGGhSbpzsg+lu2cSHFh/oDgEKbyBsgS+JTg6I5FZ
 P1S/LveP2xWsoN3K9eEyz9gpPdhRsdy2qmfv1j79sJigEnal5SBy12nytbAVJpMXww5+H7
 NQiySLseCdLvT3oViAsobJpdxF+WTPg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-pu1_UJ1qOOCCdsEC2okYuA-1; Fri, 15 Sep 2023 03:59:12 -0400
X-MC-Unique: pu1_UJ1qOOCCdsEC2okYuA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402ff13f749so14261975e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 00:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694764751; x=1695369551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I5UjlkA4DOtAXo0rFo2CE+9Oxuoa+is6gY8rdTXhXp4=;
 b=sIPdeZKwWRq4jeqFyBExhRRkxo5qUin/5aXsIJugqqYAKGqRmmxaH2xIVlBlPlDHKa
 pjicyyYU+qkk/5IKilJONKHJ3XitL5oQnwRcUhZhOoYZm9nJ4bK1idXqbQAb+ElB3gbi
 uzs3fHVNxPA8dyqnQOz1s/BhBksxefYswgwNGSbGDt2mCM9jk4snieqdPEDLHaNinLKA
 EytgYV8uyR5jNL65KoDlquJYS+7SQKBta8nfJ82jfq6qX02HlawXGyHpeVYy/qM5Bf6m
 MUP862lh3g2u209jq6Y+4zmr7QVRVSw1OlaSnyqih2oz7rHze9xwhGmE8jfnYhoIJQhU
 /+jg==
X-Gm-Message-State: AOJu0YxCfDgE7czb6V5euqmq3zMlwv6U5pTGWTQPuU7h62MOTGoFYN7P
 QnwKQhW/kZdytwcPETgEgQd9o92nu1adqaUIKDU5mh/sm7gMIvPm1hhL2wA2FHLr+yyQgzeXotB
 GAkb85m+dTdaIDuw=
X-Received: by 2002:a7b:c84e:0:b0:401:b204:3b97 with SMTP id
 c14-20020a7bc84e000000b00401b2043b97mr785053wml.4.1694764751035; 
 Fri, 15 Sep 2023 00:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKjUJtNb13ai+syLtFGtg0LvaewGZ3/7vOjwvPPgm6bcxmpgwypjhpsMoKSS2unxl9XtI52w==
X-Received: by 2002:a7b:c84e:0:b0:401:b204:3b97 with SMTP id
 c14-20020a7bc84e000000b00401b2043b97mr785038wml.4.1694764750704; 
 Fri, 15 Sep 2023 00:59:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 k21-20020a05600c0b5500b003fbe791a0e8sm3939781wmr.0.2023.09.15.00.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 00:59:09 -0700 (PDT)
Message-ID: <86ebcc33-491c-8820-2ca0-51d46b0b7375@redhat.com>
Date: Fri, 15 Sep 2023 09:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 4/5] hw/ufs: Support for UFS logical unit
Content-Language: en-US
To: Jeuk Kim <jeuk20.kim@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-5-stefanha@redhat.com>
 <c4dc2292-4690-f16f-4b70-d6f759c16633@redhat.com>
 <160581dc-bdbc-03e8-64a5-1adb818a15b2@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <160581dc-bdbc-03e8-64a5-1adb818a15b2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/23 00:19, Jeuk Kim wrote:
> First, ufs-lu has a feature called "unit descriptor". This feature shows 
> the status of the ufs-lu
> 
> and only works with UFS-specific "query request" commands, not SCSI 
> commands.

This looks like something that can be implemented in the UFS subsystem.

> UFS also has something called a well-known lu. Unlike typical SCSI 
> devices, where each lu is independent,
> UFS can control other lu's through the well-known lu.

This can also be implemented in UfsBus.

> Finally, UFS-LU will have features that SCSI-HD does not have, such as 
> the zone block command.

These should be implemented in scsi-hd as well.

> In addition to this, I wanted some scsi commands to behave differently 
> from scsi-hd, for example,
> the Inquiry command should read "QEMU UFS" instead of "QEMU HARDDISK",
> and the mode_sense_page command should have a different result.

Some of these don't have much justification, and others (such as the 
control page) could be done in scsi-hd as well.

We should look into cleaning this up and making ufs-lu share a lot more 
code with scsi-hd; possibly even supporting -device scsi-hd with UFS 
devices.  I am not going to ask you for a revert, but if this is not 
done before 8.2 is out, I will ask you to disable it by default in 
hw/ufs/Kconfig.

In the future, please Cc the SCSI maintainers for UFS patches.

Paolo


