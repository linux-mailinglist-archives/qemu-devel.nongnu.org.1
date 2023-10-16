Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4DF7CA577
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKuJ-0000CW-5x; Mon, 16 Oct 2023 06:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qsKuD-0000BC-Bf
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:33:01 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qsKuB-0004PO-7f
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:33:00 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57f0f81b2aeso2446802eaf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697452377; x=1698057177; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8e29M+XKfiu7HBFNtUvwzWtto7tlhhlytZV8sgt7OVw=;
 b=SDXGXKDD8Z4o0soP9AW/VwRLogRYez4KP/2WhZxDnbpExK3JlmSnXIzuVk9nb1O/Km
 lVTWWYiau/xIsQ2qSCPJSIk5aj8F/TnGjrLYbMYymezpHIJIWZNAzqhzlcC+rkaphtEB
 DS5Q+GE1/jPbLHiFlNNCyfoIQlbt5NaCrQ1J5BvmdBP04+V2shgy7NdjRiBnFsb9oLPL
 vEYus6bSvU6A1NH6Ja3eC9fhtN/+qDwNy0aIvQzipKZtqgcWh2+a9SOWZzJyT3Qq353Q
 PnaMKeHGJF777TLhWIxxqGVmFj0q7eyz9NSCnrrGHhfD/9mCgHhnoF95v7h798Q4ra9h
 1VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697452377; x=1698057177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8e29M+XKfiu7HBFNtUvwzWtto7tlhhlytZV8sgt7OVw=;
 b=NfXmKcI6LQmtF5i5OtP9jZNXYqJdQnTCIvmzJCXcLSfzutqZu/1grbdQGUto5aWtlr
 vuVjPCOLKtFwNSQEsrZYZKLchWrrdqzAODjwfuCmls6ObOZGp/mkosqdeexHSowLtwRi
 6TUfanlv8OrP0CgVN+eOvwrA5b57YYYoit6sIE8JNQoKVpL3BdH7p/pqna4yHBnqNN0P
 ozYslqin5KRfGPnNHZil7OLmyUi3erwwdgcReNZfNLXA7mUvFWz3PTEFT+69v+gDxxD4
 Lxy9tUIAQv1AEGPr9yq2fSjPX+QvWOvTlJZv1pU2cM76BjRhUqWzYSr2NvYdIJijc5Yx
 Bhow==
X-Gm-Message-State: AOJu0YxbJ0Q39EK2Px0U4sdRXNEBnZPd3yhSLc/uxiDwaHCsUhZuqvVA
 k/PK2OzfyZeLIPjye/n5HK7O0Q==
X-Google-Smtp-Source: AGHT+IHO9PfBnxVLjiM2f0/qv3BeA1JQJOFL3l/VzKpLkiN73/Ra0OWh1Y1GFNXDKdVPTvQJwFENyA==
X-Received: by 2002:a05:6359:2c4e:b0:164:8252:260c with SMTP id
 qv14-20020a0563592c4e00b001648252260cmr19304196rwb.8.1697452377229; 
 Mon, 16 Oct 2023 03:32:57 -0700 (PDT)
Received: from localhost ([122.172.80.14]) by smtp.gmail.com with ESMTPSA id
 i20-20020aa796f4000000b006979f70fdd5sm5147895pfq.219.2023.10.16.03.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 03:32:56 -0700 (PDT)
Date: Mon, 16 Oct 2023 16:02:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
Message-ID: <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2m60m.9e9wlnnm01vd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=viresh.kumar@linaro.org; helo=mail-oo1-xc2e.google.com
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

On 16-10-23, 11:45, Manos Pitsidianakis wrote:
> On Mon, 16 Oct 2023 11:32, Hanna Czenczek <hreitz@redhat.com> wrote:
> > diff --git a/include/hw/virtio/vhost-user.h
> > b/include/hw/virtio/vhost-user.h
> > index 9f9ddf878d..1d4121431b 100644
> > --- a/include/hw/virtio/vhost-user.h
> > +++ b/include/hw/virtio/vhost-user.h
> > @@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
> >     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
> >     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
> >     VHOST_USER_PROTOCOL_F_STATUS = 16,
> > -    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
> > +    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> > +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
> >     VHOST_USER_PROTOCOL_F_MAX
> > };
> 
> May I ask, why not define VHOST_USER_PROTOCOL_F_XEN_MMAP as well instead of
> a comment mention?

Perhaps because we will never use it from Qemu code ?

Anyway:

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

