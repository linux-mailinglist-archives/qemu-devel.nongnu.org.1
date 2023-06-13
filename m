Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6AF72EA8E
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 20:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q98S8-0005Vq-VP; Tue, 13 Jun 2023 14:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q98S7-0005Vf-Cs
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 14:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q98S5-0005ZA-Vk
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 14:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686679748;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RK8dLeYSAcezyRIucDOzMxNn8IuWyRBnfcYCOKVqcA=;
 b=AMh1ImJGCd2NzpTNsiHJJ6Tf1QvLE+3o/v27MOpCLsmqfE0gDDFnE/zn+Y3qVYlUoiVfYU
 tQVTfb4Dscy5AY8W8A3OElF/4C5QRFLiNHG9Gw9+NJgctx3d3Hsc2ua/Te04XXfTsAW0O3
 Z6CQV86bu2oUvOdQItlcf54U7DlZFm0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-4iBR1YEMPzOXdqMzsmDZkg-1; Tue, 13 Jun 2023 14:09:05 -0400
X-MC-Unique: 4iBR1YEMPzOXdqMzsmDZkg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7f4dc6ec2so37430225e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 11:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686679743; x=1689271743;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/RK8dLeYSAcezyRIucDOzMxNn8IuWyRBnfcYCOKVqcA=;
 b=hyCpFXMmYqKPWm7aZrHzx5a44nN5orU4N+dMDlHFi4mW3Qyulg6BUUWkXR/3jTBudu
 /u0+EzSALa1QS7/WTod4xwsAPk5ucyA/9rWJkVNeZ/NE+RCCIJTg/cZb6Qd8C12Szd7G
 Sln3sF0qBPdCcAiLAF+R4BphYxwh2HlbB85Xw4aIVZh3k55v2ccm4NN2uVPHtFcajlik
 +WZnSchJWiEXs2nmBroJLUJEMY6GOD6vI5lgnRimf73KM9JVcXEgn0iT3Av8NPVJfmde
 NtoAEyo3TjNzpv3uuXjIbn3j1MV8DuV4kClW31vJVDNkNr3R/zfw0bdtVaPTVdM8pjcp
 zY6g==
X-Gm-Message-State: AC+VfDxJkQJgpUY7JHGaSA7SMyz3yo9Vr2KbSQ/aJ7H/JufLG/3hzXRM
 IbuQjEeT6/U8dAK7yVkwR94emM70jEzDM78mye6mZ7CG128jtQP0m92dmMvlDII43Wvkf5AiefN
 QXYoJUTElL9Z7Ozw=
X-Received: by 2002:a7b:c447:0:b0:3f7:cb42:fa28 with SMTP id
 l7-20020a7bc447000000b003f7cb42fa28mr9934395wmi.28.1686679743029; 
 Tue, 13 Jun 2023 11:09:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iqNU9DhsF/12Vzc4xiOpsfoCJtYi9ntLgNVTJMHmQ/dzpy9rzAYIYf0VXH76ZLlZT7ccM0Q==
X-Received: by 2002:a7b:c447:0:b0:3f7:cb42:fa28 with SMTP id
 l7-20020a7bc447000000b003f7cb42fa28mr9934378wmi.28.1686679742669; 
 Tue, 13 Jun 2023 11:09:02 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k20-20020a05600c0b5400b003f4266965fbsm15233592wmr.5.2023.06.13.11.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 11:09:02 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 8/8] tests: Add migration dirty-limit capability
 test
In-Reply-To: <168618975839.6361.17407633874747688653-8@git.sr.ht>
 (hyman@git.sr.ht's message of "Thu, 08 Jun 2023 00:46:45 +0800")
References: <168618975839.6361.17407633874747688653-8@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 20:09:01 +0200
Message-ID: <87bkhjck02.fsf@secure.mitica>
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
> Add migration dirty-limit capability test if kernel support
> dirty ring.
>
> Migration dirty-limit capability introduce dirty limit
> capability, two parameters: x-vcpu-dirty-limit-period and
> vcpu-dirty-limit are introduced to implement the live
> migration with dirty limit.
>
> The test case does the following things:
> 1. start src, dst vm and enable dirty-limit capability
> 2. start migrate and set cancel it to check if dirty limit
>    stop working.
> 3. restart dst vm
> 4. start migrate and enable dirty-limit capability
> 5. check if migration satisfy the convergence condition
>    during pre-switchover phase.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

> +static void test_migrate_dirty_limit(void)
> +{
> +    g_autofree char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
> +    QTestState *from, *to;
> +    int64_t remaining, throttle_us_per_full;

See comments on previous patch about int64_t vs uint64_t.

Except if negative values have some meaning, it should be uint64_t.

Rest seems correct.

Later, Juan.


