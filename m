Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB8773F872
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:12:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4kQ-0002hQ-W5; Tue, 27 Jun 2023 05:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE4kO-0002Vx-MM
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qE4kN-0003G3-8W
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687857145;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1fCszfy9/dPj/i9TR0Bl8hvhp1qcNZI3SDObyUtDYWw=;
 b=d6rpTE6LQ0izKw834kB5smvG6qFidANU1XIuhuAFg6QHmpNRCkrrHJLz5UJg53lRhKO90R
 29ntOEiFoL6qNPOm0HZD/FScBMFB6r2ILc8gQXQ9EqXxzR8BhfpZv36lVEVi8diRE/CG8a
 CSd+IGGYJsatxpr5PcwdQ25z3/tLUH0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-ZRZqZ_4jMOW7hH3Sz2wWjg-1; Tue, 27 Jun 2023 05:12:22 -0400
X-MC-Unique: ZRZqZ_4jMOW7hH3Sz2wWjg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb76659d44so2062919e87.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857140; x=1690449140;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fCszfy9/dPj/i9TR0Bl8hvhp1qcNZI3SDObyUtDYWw=;
 b=FEWMT+gWVyps8AoKeS2JKuTb/U/yCEX0baEk4qwv8Jp9Xp8K0QGAb+Mw7kCi7Oq0oE
 SojOiD53Ys7zVt7u6Yx2hpeZ8YabNBJb/vC8mUvpiWgPFcwz3GigtztTv5psl3NO9bi1
 7EVPVD22R24lqkKnMBVkt3d6OJol/HhkRoVlMYO1SncXweNrghQwwGmtebQYxB0Yy1Db
 nES/SHoJ2S4Qxvr7VJXIOoihouAbeut5TpORqh7krBx8194+GKoCnaLSaMKhw017GPkP
 +C82H3Sa/ZeABmJ9a9jL10rwpigtM2jSIeGSfazgUIsu3CeYGehrm8zXpSH8KJ0aZpQi
 tFdQ==
X-Gm-Message-State: AC+VfDxljHoq8xdJ3hzZk7/rkSm4NG10sjF4FR7QkhU6EMZwsR558ELe
 i/M79H8SM6OszzlY8h7qRd4xez0XiaDImaLbjz5zYrAifxZ1eh4xJnUbqm9YwbycpkxL1mvghlT
 2zTykjv3wZsIurNo=
X-Received: by 2002:a05:6512:2024:b0:4f9:dac6:2f41 with SMTP id
 s4-20020a056512202400b004f9dac62f41mr4126600lfs.2.1687857140473; 
 Tue, 27 Jun 2023 02:12:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SPvRDzhzlxjUxKhQMhGMNMsaa/pIR0yMhV6/Zodj6ZhX3LthpW5tyTPaeCTKAkSJI8t0+xw==
X-Received: by 2002:a05:6512:2024:b0:4f9:dac6:2f41 with SMTP id
 s4-20020a056512202400b004f9dac62f41mr4126584lfs.2.1687857140144; 
 Tue, 27 Jun 2023 02:12:20 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 x9-20020a05600c21c900b003fb40ec9475sm3093195wmj.11.2023.06.27.02.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 02:12:19 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Steve Sistare
 <steven.sistare@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/6] tests/qtest: migration: Expose migrate_set_capability
In-Reply-To: <20230626182210.8792-3-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 26 Jun 2023 15:22:06 -0300")
References: <20230626182210.8792-1-farosas@suse.de>
 <20230626182210.8792-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 27 Jun 2023 11:12:18 +0200
Message-ID: <87352dclql.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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

Fabiano Rosas <farosas@suse.de> wrote:
> The following patch will make use of this function from within
> migrate-helpers.c, so move it there.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


