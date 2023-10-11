Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B67C56E7
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:33:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaGK-0005YD-2F; Wed, 11 Oct 2023 10:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaGH-0005Uy-G6
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqaGB-0004Tz-G0
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697034731;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DYjyP5L4pqIKB99D590XvQftimcrqKdSZZ8Tr6IzAO8=;
 b=hLzcJO7wKP9ZC0F5Eya/CFRxdoT1rSqx93q0s0xAsPL3NQE6O7SVlHKfBIjw0hyDINovMp
 ntwlBYgh/plp57wBU82tjdC712Jw+R1lLaYOzfvTWKefXRGgy5F3cYC359LIB6U6+eSbvk
 WZK9BAUezTry9bOL6E/1j6QRVutQfLQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-6-mrMsPjOGaJgvaHSdhagg-1; Wed, 11 Oct 2023 10:31:59 -0400
X-MC-Unique: 6-mrMsPjOGaJgvaHSdhagg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so4655360f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034718; x=1697639518;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYjyP5L4pqIKB99D590XvQftimcrqKdSZZ8Tr6IzAO8=;
 b=qbhRERUemf8M3V3iRy44QN/819eNEKc24ecK6hkY8onkztnEkB7e2vGdj8i5eUFUD0
 IeSPpXED7j+CvaYHcFecxvQnVWlYijSpFUkDp3HsSlCgTvdrJ8bbMoomdSfP3//UiKWP
 xHAK7JDeTWaYm/AOTp6rWwzaH6fHFGlqv0ovmmh58wihfIxUqtWMdoNVUIqX/sKdHa98
 BM4vzqWjTLiUlbH0Gq/Lv7Pq9YsQiTNsOy+DknLJ64+ujU25eP7B7mUM4KH56HLY0k+V
 lYbNu7t4ZFJyaxFV+gu6KC5Yo1212dnchuATw6TZxDGKqNcz+2SlqlqLx8ohl0PDiAbz
 IbMg==
X-Gm-Message-State: AOJu0Ywnf0lh3JhpFPHC2Px6uOKHcGI5rd6uAhM6v5TGYoY3fJsXR1xF
 u8p8t7UxX95Konp8N/LHrLwYPM9GhxlUbQfrqCYsPub46aAW4iF+S3cyl23L2LUcXVtxklplFV2
 Wwe9AMraMAsmNekM=
X-Received: by 2002:a05:6000:1189:b0:321:6936:c217 with SMTP id
 g9-20020a056000118900b003216936c217mr17735418wrx.14.1697034718572; 
 Wed, 11 Oct 2023 07:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO4TX6pyhWjvidK2HF3DE8sWWoxaNCGE3zrjydYoI0AdCtvcgiZ7gmluJ+V+mG1RL2F21Vog==
X-Received: by 2002:a05:6000:1189:b0:321:6936:c217 with SMTP id
 g9-20020a056000118900b003216936c217mr17735408wrx.14.1697034718340; 
 Wed, 11 Oct 2023 07:31:58 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e15-20020adff34f000000b0031c6e1ea4c7sm15698200wrp.90.2023.10.11.07.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:31:57 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 9/9] tests/qtest: Don't print messages from query
 instances
In-Reply-To: <20231006123910.17759-10-farosas@suse.de> (Fabiano Rosas's
 message of "Fri, 6 Oct 2023 09:39:10 -0300")
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-10-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:31:56 +0200
Message-ID: <878r898c2r.fsf@secure.mitica>
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
> Now that we can query more than one binary, the "starting QEMU..."
> message can get a little noisy. Mute those messages unless we're
> running with --verbose.
>
> Only affects qtest_init() calls from within libqtest. The tests
> continue to output as usual.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


