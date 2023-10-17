Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC87CBCC3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qseq2-0006jk-Rl; Tue, 17 Oct 2023 03:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qsepy-0006cS-8G
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:49:58 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qsepq-00061R-Am
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:49:57 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7b5fd0b7522so1558090241.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697528989; x=1698133789; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/ilIXEltbFSCy9BUT4uFYAZHM04KSQPl+dPNSxDO2Ls=;
 b=bvP+jjujB2VOTqbw+XdRH/2kz8kby3scOWq1ZVXLd6xWtpk2vr/f+paxV6tzTkDe81
 ttsif8icwKzat3vp80TH9isYwN9YIydtfau8Q1pc/FoFIkAFCSODxHXxxechz7nXOcoH
 xAJ7DGu+IG1REln//PYa6uwhlZ2hDAb1VMAJgw2bgrPE8Wh9Ec2TVnDp5Z+hb2Ubbno1
 K9Y98beHzW8ZsevS5YHO8XRmmLKeBB5BSnmcKMLSHVPM7a0WijPqAIoTDYi35P3aKoA0
 fktYy8Dj2GvgiuQyTP8t+7reFfE2KsrILRXbKbWOLGK1kqdkKnOdxwG2DA5xAXaFUgEl
 w80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697528989; x=1698133789;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ilIXEltbFSCy9BUT4uFYAZHM04KSQPl+dPNSxDO2Ls=;
 b=RlLl8uFPeXbejGIwYIPFcdw7DrMYIcL3f8uAJvAp3Y8Sv/oQf5rkC+SicP/SLXIl45
 3hNyYbbG3YJsM8ZGsC2BX4zgHRk6ygCPburn34RfU/Gv83xhL7TbKKSLDMfkeFQqXTSR
 LQyVivtDOO/Y2GS0g6lYNcOWVN6HUP80t+M9oLcjXrObtFyb8h5bTW+13WjWApCCkUq3
 vHxAFPrTJV+ePSZWKuGBSl5zife+H2W8HsA9t6xYkKIH8FRl/LreMfJ0JrUYjLyL6JCh
 0YXXULuZhQUqdHxd9AtoFuT8ZEgdSi5iNY6rs+ruOkMO5fOQsZeromwaTTZ10hyjfD5d
 BGqQ==
X-Gm-Message-State: AOJu0Yxd894ccS6MXtDbGCmaeUBhri62x6rp/s+eyIwEjxYEFNBHlf7i
 3srrBqDO5PrXB8E5cVp2xDEw7A==
X-Google-Smtp-Source: AGHT+IHzLbDqPNd54WVKw1dWWv/CpJQ6WPMvEJ6t7hN9qZahkj6/h0WrzH1i978ymnFkYQKZNuFmPA==
X-Received: by 2002:a05:6102:2049:b0:457:eee6:c105 with SMTP id
 q9-20020a056102204900b00457eee6c105mr1302471vsr.8.1697528987272; 
 Tue, 17 Oct 2023 00:49:47 -0700 (PDT)
Received: from localhost ([122.172.80.14]) by smtp.gmail.com with ESMTPSA id
 x25-20020a056a000bd900b00682d79199e7sm772100pfu.200.2023.10.17.00.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 00:49:46 -0700 (PDT)
Date: Tue, 17 Oct 2023 13:19:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Parav Pandit <parav@nvidia.com>, Anton Kuchin <antonkuchin@yandex-team.ru>,
 Yajun Wu <yajunw@nvidia.com>
Subject: Re: [Virtio-fs] (no subject)
Message-ID: <20231017074943.gft6f672o6xzeepa@vireshk-i7>
References: <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
 <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
 <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
 <e19eb113-89b1-92ed-3375-8bc93c1ff39c@redhat.com>
 <8f51f02b-4676-c566-7304-f63e76df74ba@nvidia.com>
 <9a36a319-4567-f297-f14a-2025792ae93f@redhat.com>
 <87lecapxi4.fsf@linaro.org>
 <fbe05651-a65a-23d0-52be-2d611cc5740d@redhat.com>
 <87lec6mt03.fsf@linaro.org>
 <a7c01dd0-2b41-e294-f20c-a1edf6562a78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7c01dd0-2b41-e294-f20c-a1edf6562a78@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=viresh.kumar@linaro.org; helo=mail-ua1-x932.google.com
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

On 13-10-23, 20:02, Hanna Czenczek wrote:
> On 10.10.23 16:35, Alex Bennée wrote:
> > I was going to say there is also the rust-vmm vhost-user-master crates
> > which we've imported:
> > 
> >    https://github.com/vireshk/vhost
> > 
> > for the Xen Vhost Frontend:
> > 
> >    https://github.com/vireshk/xen-vhost-frontend
> > 
> > but I can't actually see any handling for GET/SET_STATUS at all which
> > makes me wonder how we actually work. Viresh?
> 
> As far as I know the only back-end implementation of F_STATUS is in DPDK. 
> As I said, if anyone else implemented it right now, that would be dangerous,
> because qemu doesn’t adhere to the virtio protocol when it comes to the
> status byte.

Yeah, none of the Rust based Virtio backends enable `STATUS` in
`VhostUserProtocolFeatures` and so these messages are never exchanged.

The generic Rust code for the backends, doesn't even implement them.
Not sure if they should or not.

-- 
viresh

