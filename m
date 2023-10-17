Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D47CBA38
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 07:38:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qscl6-0005Qr-D7; Tue, 17 Oct 2023 01:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qscl2-0005Qg-Or
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 01:36:45 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qscl1-00045b-9v
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 01:36:44 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5c91bec75so34445085ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697521002; x=1698125802; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iyrD283arMtsQUuxiFuCVfNi6Sr8sKMypLWDqm0xEaY=;
 b=FN3eGjyy9vzVW1Zt0/hMNIK7ZY1z8Xh+xwTFCZhoW0WDu7e7/EZ+ggzpXJi4xk/r2s
 lRYpGO2u7CKAMdS4vovwJj5WKvfHUO2ds67w42rYRgh03y3FY+Myy1Iy9STqBHDkUtz3
 CJLQNQR1Gr8iQgAqbivW3+XfA2knzvTTaTLsfEDXrYqS6595PWkXv6eyNFcOArAqB+R0
 qBrGzM8upVhtlTKxqilQyWExYBP2bU+DCbf7iDRMbFi1YKnavAXN5FcykNpoZ55Ct0ZU
 hniqwumN/2NCHk9zPJ0gfUOLXmvdSBZHsOyB8+KKegbgQga8B7OS4F3bVlXDevnrLJ1M
 lhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697521002; x=1698125802;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyrD283arMtsQUuxiFuCVfNi6Sr8sKMypLWDqm0xEaY=;
 b=Y23iM81ytL6euISo/+3a9GYJLZtyO0CZxKvOm2vlsacC/0tmHlEbLevBE7GBg6stV0
 2YEMxVKOZosKDbfH4DStlPThhGT8ESfZhzFsTsxRWSMTAJ+OmdD+ud9Yvk9kjgzX8X+a
 gkTqOXcjXQJ5iJVUZx0VwOiZ57V5Iu1iuMKEaCPKkDxLk6FfCetUVqXhwvMa2ABkhEUU
 bYSNezGmGob75ez+vxMr8qR5LbbCTNBgUVQm15k5fc/K+LLhsRBn5+W6ynnTnQ4fhqY0
 ukfQNyFzDrP59JrkNmizFs/kCg9aAIsFoEQ875sZhBXFH9WqtBJKPRTstnWMN3PE1vja
 bj5w==
X-Gm-Message-State: AOJu0YxybCwsxH1LxldgdysLwjqt2Ckcrl8IDvc0jkqEiYxmUNnU7DLL
 ZK2AWN9DhJG7G+yz49IPtKTtRQ==
X-Google-Smtp-Source: AGHT+IEEs+x6xQImF7gKntIEOcde6YYN4YUa0T+7wKdEl30/umkqEI2z4+OPLe08YgYQ81T/j5HneA==
X-Received: by 2002:a17:902:fb45:b0:1c3:3c91:61cc with SMTP id
 lf5-20020a170902fb4500b001c33c9161ccmr1204073plb.13.1697521001626; 
 Mon, 16 Oct 2023 22:36:41 -0700 (PDT)
Received: from localhost ([122.172.80.14]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b001c72f51b84asm547301plg.52.2023.10.16.22.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 22:36:40 -0700 (PDT)
Date: Tue, 17 Oct 2023 11:06:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
Message-ID: <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
 <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
 <87lec2dc7r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lec2dc7r.fsf@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=viresh.kumar@linaro.org; helo=mail-pl1-x630.google.com
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

On 16-10-23, 12:40, Alex Bennée wrote:
> 
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 16-10-23, 11:45, Manos Pitsidianakis wrote:
> >> On Mon, 16 Oct 2023 11:32, Hanna Czenczek <hreitz@redhat.com> wrote:
> >> > diff --git a/include/hw/virtio/vhost-user.h
> >> > b/include/hw/virtio/vhost-user.h
> >> > index 9f9ddf878d..1d4121431b 100644
> >> > --- a/include/hw/virtio/vhost-user.h
> >> > +++ b/include/hw/virtio/vhost-user.h
> >> > @@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
> >> >     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
> >> >     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
> >> >     VHOST_USER_PROTOCOL_F_STATUS = 16,
> >> > -    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
> >> > +    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> >> > +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
> >> >     VHOST_USER_PROTOCOL_F_MAX
> >> > };
> >> 
> >> May I ask, why not define VHOST_USER_PROTOCOL_F_XEN_MMAP as well instead of
> >> a comment mention?
> >
> > Perhaps because we will never use it from Qemu code ?
> 
> Vikram's work on enabling xenpvh support will mean enabling grant
> support and while I suspect most VirtIO backends will be within QEMU
> itself if it ever want to off-load something to a vhost-user backend it
> will need to ensure this flag is set.

Hanna,

It would be good to define it then in the current commit itself.

-- 
viresh

