Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC547CF84B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:07:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRnF-0001La-83; Thu, 19 Oct 2023 08:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRnC-0001Iz-GN
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRnB-0003Kj-4V
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697717180;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vYCi4yps77wnPous6tl1/uvUcq/JxvKkhddXUaHZbS8=;
 b=KTXUTaHMJx7xAqlJTKdnnE43k5cbxQK8Hn1u3lJdbjQRMR07+sxL2GcJ4hJ3+lJn3NY77/
 siuzbjVdd0Gyqkxa/7VxbDc/3wwOrKav5AMM2QoE5Pvp6cToV17lP6POCqmU0CH0XsLS1D
 0X/Dyljx4Cs0FWuxjQ+DlG7ZbsUPJSc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-X3X5m0FCOIiIA1_pPV3A2A-1; Thu, 19 Oct 2023 08:06:19 -0400
X-MC-Unique: X3X5m0FCOIiIA1_pPV3A2A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507d0e4eedaso677575e87.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697717177; x=1698321977;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vYCi4yps77wnPous6tl1/uvUcq/JxvKkhddXUaHZbS8=;
 b=BJSgdjv7h/vpExrkRDibatoIrFOJ1tK+ue3I+oBhYd/SZqYU5h8po+9VBvOn7NsUlX
 FUA93umIXWiHzlFrD2Q6igaSCH4w1SrJj+TPdHb4GNoTGX4nUpk3QWRwNK2iKpUOdsqG
 UY/DSmZF8iUelfP1YeO5j5XWbtIJ1IrhoMvx3LWQfxnIlV66S6NRjmEfDh26M3CZPwMD
 zLsUak19H11mnBXbsaYBCpvBemv1jnV6BJ2ZQwuK0LlccZobM412nmZ5EgOUomg4BDld
 R2EGULbv+o14wI0fTdDVerHPdgxBrAon3WLICLKlG2zrow7HmG4NhVKQBaTq9+VbQ9k4
 SNnQ==
X-Gm-Message-State: AOJu0YzqOXuSHbCXN71B4u5EyZMvMc1FdTn9ANbkL+3QMUuilXuiNU3o
 1biW/8hqgStDwMnBG8KwKYhhj+IrECYv7mrBwGq8ZtQaB6PWT+vmSXQjqbNcSadYNktg2UIsntU
 lmn8ALDlpaNYYjkI=
X-Received: by 2002:a05:6512:5d5:b0:507:9787:6773 with SMTP id
 o21-20020a05651205d500b0050797876773mr1306980lfo.36.1697717177779; 
 Thu, 19 Oct 2023 05:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI62+s6sX8HKvQXLha48RVA6hBSAQ3RPfiFRshhX4WrHfYaKGFsaj9su9wQNjxcWf1ZFuV4w==
X-Received: by 2002:a05:6512:5d5:b0:507:9787:6773 with SMTP id
 o21-20020a05651205d500b0050797876773mr1306967lfo.36.1697717177463; 
 Thu, 19 Oct 2023 05:06:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d14-20020a056000114e00b003232380ffd5sm4294785wrx.106.2023.10.19.05.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:06:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 11/12] tests/qtest/migration: Allow user to specify a
 machine type
In-Reply-To: <20231018192741.25885-12-farosas@suse.de> (Fabiano Rosas's
 message of "Wed, 18 Oct 2023 16:27:40 -0300")
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-12-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 14:06:16 +0200
Message-ID: <87il724y13.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Accept the QTEST_QEMU_MACHINE_TYPE environment variable to take a
> machine type to use in the tests.
>
> The full machine type is recognized (e.g. pc-q35-8.2). Aliases
> (e.g. pc) are also allowed and resolve to the latest machine version
> for that alias, or, if using two QEMU binaries, to the latest common
> machine version between the two.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks.


