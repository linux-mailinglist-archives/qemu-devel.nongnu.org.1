Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60872EA89
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 20:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q98Qy-0004rr-Hd; Tue, 13 Jun 2023 14:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q98Qw-0004rc-An
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 14:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q98Qu-0005Uy-Oe
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 14:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686679676;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIwjUe70lnPjCqJmJHLMSZF8zyEQb/B/oYc60UT7piA=;
 b=U6La9usjfD3LaPAfKH+9QYRHx155ko7EzckeVX1g9I2nrFHaZzjSzOlzgvwM+d6jORjH1o
 heovfPRqb9XrkofSYGCPI9IWeghf4XnbBZU3McHIGlFj5eLONzqSPJ+q/ZSPosBOTIASOG
 VgN70oI6MWlXKtWsOFUs3Ik9wPbclMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-CoHWspXvOmSwth4T7dohiA-1; Tue, 13 Jun 2023 14:07:53 -0400
X-MC-Unique: CoHWspXvOmSwth4T7dohiA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30c6060eb32so8463145f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 11:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686679672; x=1689271672;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EIwjUe70lnPjCqJmJHLMSZF8zyEQb/B/oYc60UT7piA=;
 b=ZlIkTM2cJPCVZcBSlq+/QAdusOzWXYdDEIVZ9Jmpj/8rNmAZbljx5UChaVsQe7m8LI
 OqWe/MavTqJ1J7gJY43yTZ8ZVrvkt1nsIxypxBQBVNlRzb05YU13SpUdFVebKb64nkuk
 gv6bkUpt+CFUZ/kgLSv2Tu7flM/WIPplFZthpTJ9siwlotYSqwmP61stB6o8/hTmZRhj
 YeHc8ybKfkvLoM8FJ8omM9/38sn9UkjXmpJHlgiwgYzcd0SVododIgEM4buzORfqabyl
 4m0KqQAV4j6SihI3at1kvwz8PiEPd5AGquexdlf9bco6dDDkXpzfWzETx6KzmJXfatZ8
 4prQ==
X-Gm-Message-State: AC+VfDwYOQjygBgHK28WNZKH4lffX+vWJmzIA66qQv0DGcEx4Gkc9N2K
 xgYH+vXfieNYwjbJUx9GGwY1nGGZCQLJ2Zknk7CaaeI6FfJv5uO8E0ffUgRF0jN8hVSXKUE5GJq
 JJjVsBJkDvRlVVKc=
X-Received: by 2002:a5d:4142:0:b0:30f:d22c:83e1 with SMTP id
 c2-20020a5d4142000000b0030fd22c83e1mr1013148wrq.51.1686679671739; 
 Tue, 13 Jun 2023 11:07:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69MPa30I3jFcRuehRIzJzMyd5X0fw3q5WWxgSsJlwxpnW3kkQj79ToHSRBUrMSmGhuf0o5HA==
X-Received: by 2002:a5d:4142:0:b0:30f:d22c:83e1 with SMTP id
 c2-20020a5d4142000000b0030fd22c83e1mr1013130wrq.51.1686679671405; 
 Tue, 13 Jun 2023 11:07:51 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 y14-20020adfdf0e000000b003063772a55bsm15989393wrl.61.2023.06.13.11.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 11:07:50 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 7/8] migration: Extend query-migrate to provide
 dirty page limit info
In-Reply-To: <168618975839.6361.17407633874747688653-7@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 08 Jun 2023 00:21:58 +0800")
References: <168618975839.6361.17407633874747688653-7@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 20:07:49 +0200
Message-ID: <87fs6vck22.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Extend query-migrate to provide throttle time and estimated
> ring full time with dirty-limit capability enabled, through which
> we can observe if dirty limit take effect during live migration.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Nit for the resent.

> +int64_t dirtylimit_throttle_time_per_round(void);
> +int64_t dirtylimit_ring_full_time(void);

int64?
> @@ -267,7 +278,9 @@
>             '*postcopy-blocktime' : 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
>             '*compression': 'CompressionStats',
> -           '*socket-address': ['SocketAddress'] } }
> +           '*socket-address': ['SocketAddress'],
> +           '*dirty-limit-throttle-time-per-round': 'int64',
> +           '*dirty-limit-ring-full-time': 'int64'} }

int64


> +/* Return the max throttle time of each virtual CPU */
> +int64_t dirtylimit_throttle_time_per_round(void)
> +{
> +    CPUState *cpu;
> +    int64_t max =3D 0;
> +
> +    CPU_FOREACH(cpu) {
> +        if (cpu->throttle_us_per_full > max) {
> +            max =3D cpu->throttle_us_per_full;
> +        }
> +    }
> +
> +    return max;
> +}

s/int64_t/uint64_t/?

> +
> +/*
> + * Estimate average dirty ring full time of each virtaul CPU.
> + * Return -1 if guest doesn't dirty memory.
> + */
> +int64_t dirtylimit_ring_full_time(void)
> +{
> +    CPUState *cpu;
> +    uint64_t curr_rate =3D 0;
> +    int nvcpus =3D 0;
> +
> +    CPU_FOREACH(cpu) {
> +        if (cpu->running) {
> +            nvcpus++;
> +            curr_rate +=3D vcpu_dirty_rate_get(cpu->cpu_index);
> +        }
> +    }
> +
> +    if (!curr_rate || !nvcpus) {
> +        return -1;

What does -1 brings up that 0 don't?

i.e. returning 0 here would mean that nothing has been dirtied or that
we don't have any vcpus running, right?

Later, Juan.


