Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A827D7CB5
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 08:10:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvtY6-0001tD-2t; Thu, 26 Oct 2023 02:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1qvtY3-0001t3-Kc
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:08:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1qvtY2-0006wu-3x
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 02:08:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso12485335ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 23:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698300527; x=1698905327; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GVNLAAz/+fFw241AwGbx5G0RRJSZDrjdJeXm1jd7+YI=;
 b=t44ChD9i0Jro2ejkkUeVt1iXtbTeV1dIfFAsbFPu6E8qJr9V2cgFDzVNujv+i9H0s1
 +IhzP+SX8AqtC4u2FlztCLU3PE9uSzjwwe1I2XOuYnA62+qjOYKULDjaIZSgqVAP4Kwo
 vZocg1kaWEDQjr3B0RgFbr2fCjMz47YsvlThBaeS3ad65r13g9NHPNtkuf80KArdD3Bg
 qYo3VjNY6SjBMlPuwL75xMiR+8hyRLQiq3lXUOsAdd7lfiPPCXb2PPn3DrXYPL4Iog19
 XPQPwpmPylQN4sdaxV31KYXtVihC6Ps95J3kkojVwonO1I7KBNit0FZk8P2rFPzaqAiN
 5/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698300527; x=1698905327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVNLAAz/+fFw241AwGbx5G0RRJSZDrjdJeXm1jd7+YI=;
 b=EI0GsY/rSZIkUJLiy3RkuhdZ93oVzA/TUc0rU5Fx4TcKc7+k4d1CYAyZnYR//+UBr1
 QB6aRj/FDzNKjfAj5YLZe9xmZrwWwTsia1TQlLXIvA/4SXLj2icFlwjZUgnrdxs8rRD+
 zokM/XmSmVyrU07rh3XMFb2z5H473NkhhvaXuE4/0fn9cRloyTLjOx84oyM9mcA+Sun/
 /Q39tF9PrWIhe4USHyGW9qFhXB4uwC+LI6XkaF7YKAI8qliPwmL5f1Rsend9VdhzJjHY
 XgKp5xFWQrSXtohMNZe8wve2URFTmOu4JMW+QU0S30AJ89D/tiuYdQEFAQGBfxicHqzW
 M+SQ==
X-Gm-Message-State: AOJu0Yw2C35y+p2K4aHGwKQUVay7NcD/8iZx8b24pOBhlPx86M/diIjv
 HR5td90Qh9ystGyBPaxvKae+Ig==
X-Google-Smtp-Source: AGHT+IFZshmN1XUkXu+MASdqvRWbIv8R6PlTUS9FTjcSFzkNwrumqK2RZhQV48Br63/CJwNDGkJ/VQ==
X-Received: by 2002:a17:902:e887:b0:1c5:cf7c:4d50 with SMTP id
 w7-20020a170902e88700b001c5cf7c4d50mr2462826plg.18.1698300527450; 
 Wed, 25 Oct 2023 23:08:47 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-209.hinet-ip.hinet.net.
 [211.75.219.209]) by smtp.gmail.com with ESMTPSA id
 e12-20020a170902ed8c00b001c76fcccee8sm10245163plj.156.2023.10.25.23.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 23:08:47 -0700 (PDT)
Date: Thu, 26 Oct 2023 14:08:43 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: mst@redhat.com, viresh.kumar@linaro.org, lulu@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: rng: Check notifier helpers for
 VIRTIO_CONFIG_IRQ_IDX
Message-ID: <20231026060843.GE111732@leoy-huanghe.lan>
References: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
 <20231026050621.GA111564@leoy-huanghe.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026050621.GA111564@leoy-huanghe.lan>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=leo.yan@linaro.org; helo=mail-pl1-x632.google.com
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

On Thu, Oct 26, 2023 at 01:06:21PM +0800, Leo Yan wrote:
> On Wed, Oct 25, 2023 at 11:18:41AM -0600, Mathieu Poirier wrote:
> > Since the driver doesn't support interrupts, we must return early when
> > index is set to VIRTIO_CONFIG_IRQ_IDX.  Basically the same thing Viresh
> > did for "91208dd297f2 virtio: i2c: Check notifier helpers for
> > VIRTIO_CONFIG_IRQ_IDX".
> > 
> > Fixes: 544f0278afca ("virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX")
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Tested this patch and the vhost-user-i2c device works with it:

Sorry for typo.  Here I am meaning the vhost-device-rng device.

> Tested-by: Leo Yan <leo.yan@linaro.org>

