Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE07AFAC9
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 08:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlNks-00086x-5a; Wed, 27 Sep 2023 02:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qlNkq-00086a-NJ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:10:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qlNkp-0002ip-9h
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:10:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so8509994b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695795033; x=1696399833; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SX36ZHk41O/e4eEncMt2XXIzDNkfD6695W+JsbFodkg=;
 b=pF1rA3htu2CBQCDxqDO0vbMZvmTry7aQZjfaeW5x4sjvWCflPq/zIdeFFtd0nw/8bh
 S69/dEguPBrTHwna0JNfPKooNgWK+1vKIRHMxX6q92z1JHRQU30WUyjKiiLXDXNtL9tM
 PzITse+zjIQyj+FA5J+K88PUymKEObuzbcTcQPBaAKVkPnY1TJz0BENa8cabIaOZz9YH
 Qlb9fAyBv83y+dtBb6GRqaiQPS9Fmsf+156k5A5KYqqRP5yWMIzSnUznspvOfh4ZhWZy
 Qvs7IH51IIuJv1dygttsUvPNWQI4dcNRf1mZwrUgB03l8yLaAp6G+9AQYKTu5orUBUfF
 vw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695795033; x=1696399833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SX36ZHk41O/e4eEncMt2XXIzDNkfD6695W+JsbFodkg=;
 b=w1Y89wyTVFVYPfECbuWN7zxQ9V19cIT+QR0BFgTGhjp5RunPQTEKi8GMXXbT464y3v
 N9xSPSDb2sLutZgtJoTe0irOarByNLO52582ugdrlLbnqeCaBInu5n6ZkWEmyK3X6s4N
 OSOHibOepy7qVWyexQdNnfCxg6ZSEB4/aWM0scT3cYGj5gSVXkor6hQQtZ/UYVEQUf1o
 ntUmTLTslGFROK9Qco9lE2UieO/9be+uQskakJ66GQfiF+sfmes5RumliBBvpyj9a1Dn
 HRCogfmcJmakxyX7um3NkhLbVQegWWy2/tE6Kl6V/X3PjrHWkywN3tnE0S6SydtHFV8h
 c6Ow==
X-Gm-Message-State: AOJu0YxHHGM5zXPB/54vTcxhO2k585GQVAfd6TVSuz4cSxzRzLaKiOAT
 uVCVkrF7JdW05k9KWECBzon0qg==
X-Google-Smtp-Source: AGHT+IEu1SPzGg3xhJkrgBAWGg5FuI8gEELcd/7aq/hOjECQ762wAJEobG31/GVKoSON6eTl/NDjIQ==
X-Received: by 2002:a05:6a21:185:b0:15e:108c:35b0 with SMTP id
 le5-20020a056a21018500b0015e108c35b0mr1311736pzb.4.1695795032687; 
 Tue, 26 Sep 2023 23:10:32 -0700 (PDT)
Received: from localhost ([122.172.81.92]) by smtp.gmail.com with ESMTPSA id
 n6-20020a170902dc8600b001c5fe742a82sm8080905pld.113.2023.09.26.23.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 23:10:32 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:40:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 mst@redhat.com, boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 armbru@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net
Subject: Re: [PATCH RESEND v5 2/3] qmp: update virtio feature maps,
 vhost-user-gpio introspection
Message-ID: <20230927061030.tsbbkm5k45zmtxlv@vireshk-i7>
References: <20230926224107.2951144-1-jonah.palmer@oracle.com>
 <20230926224107.2951144-3-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926224107.2951144-3-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=viresh.kumar@linaro.org; helo=mail-pf1-x42f.google.com
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

On 26-09-23, 18:41, Jonah Palmer wrote:
> Add new vhost-user protocol feature to vhost-user protocol feature map
> and enumeration:
>  - VHOST_USER_PROTOCOL_F_STATUS
> 
> Add new virtio device features for several virtio devices to their
> respective feature mappings:
> 
> virtio-blk:
>  - VIRTIO_BLK_F_SECURE_ERASE
> 
> virtio-net:
>  - VIRTIO_NET_F_NOTF_COAL
>  - VIRTIO_NET_F_GUEST_USO4
>  - VIRTIO_NET_F_GUEST_USO6
>  - VIRTIO_NET_F_HOST_USO
> 
> virtio/vhost-user-gpio:
>  - VIRTIO_GPIO_F_IRQ
>  - VHOST_USER_F_PROTOCOL_FEATURES
> 
> Add support for introspection on vhost-user-gpio devices.
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/virtio/vhost-user-gpio.c |  7 +++++++


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh

