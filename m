Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C97ADB02
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknD7-0007rp-Pb; Mon, 25 Sep 2023 11:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qknD5-0007qn-QS
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qknD4-0004vA-FT
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695654558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgQk67ZkzsEzSepBPj3dJXz8uqNJJzLC7JIfIePaJds=;
 b=JSVOi+e/0yRrm4VYMDxYnHFTQ2pPJMx7sjQ5stp3ZL5eaANaB2ZoxJ8oMuPkhXB0GNT5fB
 3rqf/uxwT6cWPcib19eQ/LQSKvSEfFUf4mLEuPQwWe5tBJ1gs+CiCFf8eDvs1VB1itCYJo
 yXpdi47uJYoOSbMtWLCc/Ul2fdsGjnY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-DiZQkBrGNNGRLNc51N8pOw-1; Mon, 25 Sep 2023 11:09:16 -0400
X-MC-Unique: DiZQkBrGNNGRLNc51N8pOw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40525249280so60728625e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695654555; x=1696259355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgQk67ZkzsEzSepBPj3dJXz8uqNJJzLC7JIfIePaJds=;
 b=XFEsi9PUJTm71s0rF67M4l2MDnS+EcOUrIwrhkP1VkARlAMQJpw/G7oSl10i3pRrNF
 YQSSynF1yAo9vpKxHcgMge0C34fqFl5P6aCoFjTyx8qpi+rFYSD0iuMc7cCAqICi0nK2
 4/bZ6BE5l5+5ToaXr8Uc+K2e9Gj+75S2g4kQSKYWEuCehaxJ9Qqv9KBuIeLuHu5m/15D
 yFcF/cJmVdqTBTVVmaZNwZQoVm5kjbORFRD7mLsWaQKEWOiSv/lYKOZbrzwedhFUp20y
 57QpVaN8TLBvPh9CU5IUsKtuRyTeMlBavOKLiXClwZKw7yACyBKEfB0lwi+LY9QLfMaD
 WoHw==
X-Gm-Message-State: AOJu0YwhdweLiusCrXpGHEcW09VllVyrr3QYHdZ1DmWV+AFk1Itkfy6k
 Z2pLd7+N8P6paZzvHH/EJ5hjgzj2+FXscxi5pVJ4bSK4U/+6qbK5lHTBcbLl3bU/4Ne6VzvkeUy
 UrsNkcaihHYjieBg=
X-Received: by 2002:a05:600c:331c:b0:405:959e:dc6f with SMTP id
 q28-20020a05600c331c00b00405959edc6fmr1371223wmp.37.1695654555404; 
 Mon, 25 Sep 2023 08:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoJrk0nCeq/r3xXNX/7bE4APkb33ECCBLkgDe/GAUQHZSrUdId7hbOLJFRwQOdWBKVHrtkVg==
X-Received: by 2002:a05:600c:331c:b0:405:959e:dc6f with SMTP id
 q28-20020a05600c331c00b00405959edc6fmr1371207wmp.37.1695654554990; 
 Mon, 25 Sep 2023 08:09:14 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-48.web.vodafone.de.
 [109.43.176.48]) by smtp.gmail.com with ESMTPSA id
 d18-20020a05600c251200b00401e32b25adsm12527166wma.4.2023.09.25.08.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 08:09:14 -0700 (PDT)
Message-ID: <18979284-cb15-4122-bcde-6aecb9a2134a@redhat.com>
Date: Mon, 25 Sep 2023 17:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] m48t59-test: remove shadowed variables and cleanup
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com
References: <20230925144744.527958-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230925144744.527958-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 25/09/2023 16.47, Paolo Bonzini wrote:
> Rename the variable "s" and, while at it, avoid the chance of an overflow in the
> computation of ABS(t - s).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/qtest/m48t59-test.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)

I've got a patch for this in my pull request from today already:

  https://lore.kernel.org/qemu-devel/20230925090100.45632-4-thuth@redhat.com

  Thomas



