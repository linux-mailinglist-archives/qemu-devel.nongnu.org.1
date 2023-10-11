Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB367C5529
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:22:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYbh-00011z-9P; Wed, 11 Oct 2023 08:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqYbe-000107-US
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqYbY-0004EU-4d
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 08:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697028383;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgEQugV/bpfARECYLboDfmW5lUVInp+qi/rTvG3zcL0=;
 b=EoB7AjHSXGuOu6WloHRXOvyIZQBMBofsyIY5DAujBH9MfVGoE7q3w+vrcQPdw7S8//y0HK
 3zy7rbpVrg9QzwYYo8YRkPR0BKzaIoppK1fMmc/QJdniJs2ONIvZsHboOUaTspeV2sRfTy
 6U1oqaovJOUhWKUZ/bIpnc/jsUHHwJA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-fxYxMOgsOz-e71O9rNFb6w-1; Wed, 11 Oct 2023 08:46:21 -0400
X-MC-Unique: fxYxMOgsOz-e71O9rNFb6w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3231d7d4ac4so4830881f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 05:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697028380; x=1697633180;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgEQugV/bpfARECYLboDfmW5lUVInp+qi/rTvG3zcL0=;
 b=jQv1oP6Vgsyuxea3ClAuvgiTP2JbSgrxDMVsOupS58HWJo/RG+yqjEgctFvefjLyd6
 +0uqbowF0wX9T3S0kfTJ2EGr7eC0RJYwOeYor0V7zwe/l+A+59Wkp6G2IgIKvHvOavxp
 w47m32MmZoQNnp33w9e0LbrMZf8o53togCnlh8+5QKaMqSMvGtBRbecDQdMxNmU5N/v9
 vKpjMw0z/DXBYUR/f/f1vu4Qx8+gGjRIM3Cks5VauEiqMlOkAwb9kPBDc3JlJ57k6oMo
 fo8WeUb0NWuBik6r3V/I2e9Xl4XKtYxACw/oWi2KE2+ZiQJKQH0xTqvV/ezqjCSeDyqm
 GE0w==
X-Gm-Message-State: AOJu0YxeMSlovvdjvqXgvMNBv6208keNjoHPJcI08raAYBzNkAVLC2Yu
 TRZahXAiQJ4eT+RB8HzJ7fSAzQUfEg91rdqo4SYWf4VDh82SJ1R9tKJNel4aNOeh093Iwq+fGLT
 Pdr86xk2ytIC7J6g=
X-Received: by 2002:a05:600c:2298:b0:406:4573:81d2 with SMTP id
 24-20020a05600c229800b00406457381d2mr17764829wmf.39.1697028380639; 
 Wed, 11 Oct 2023 05:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxiEBhpB4ULV4Tjaw4yazVp53WCrFrtjPLVAz5qImqrtqd1V2D/uX6plOj6OueFZEYmsOUFg==
X-Received: by 2002:a05:600c:2298:b0:406:4573:81d2 with SMTP id
 24-20020a05600c229800b00406457381d2mr17764806wmf.39.1697028380196; 
 Wed, 11 Oct 2023 05:46:20 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c219100b0040646a708dasm16715772wme.15.2023.10.11.05.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 05:46:19 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] migration: Use g_autofree to simplify
 ram_dirty_bitmap_reload()
In-Reply-To: <20231011023627.86691-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 11 Oct 2023 04:36:27
 +0200")
References: <20231011023627.86691-1-philmd@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 14:46:18 +0200
Message-ID: <87r0m1ba3p.fsf@secure.mitica>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Based-on: <ZR7e3cmxCH9LAdnS@x1n>
> v2: Do use g_autofree...

Reviewed-by: Juan Quintela <quintela@redhat.com>


