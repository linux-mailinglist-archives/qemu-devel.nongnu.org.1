Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE157BD7B5
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:53:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmwZ-0004Mk-ND; Mon, 09 Oct 2023 05:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qpmwX-0004LF-Jg
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qpmwN-0006iz-6W
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696845162;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mat4o5l5NRzOAbSXT2+884hQtlwqveRs1oyxWA2hBas=;
 b=JbQsK6IFQbYmYWW0fHqLFKv1ND09YH05WIO5O2/zkQbHRVvUlpaJW/BF6UhXsQeoVO2IzS
 2wqTjezcOsyDiHl2a8L3rvOQR1uOlvhXDsJBaTrvX0q8fLO6TykqPLbhSSM80mQo2+tKr5
 ypFqvwZhTgvayZwrjcuo+cekeOrGabo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-al_ee1uNNMSZMOg6PEtlMA-1; Mon, 09 Oct 2023 05:52:41 -0400
X-MC-Unique: al_ee1uNNMSZMOg6PEtlMA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4054743df06so31445445e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845160; x=1697449960;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mat4o5l5NRzOAbSXT2+884hQtlwqveRs1oyxWA2hBas=;
 b=unbLcsldqrPeZ8PhsoDKmwaF+7UzMBYgZT8K7rlcxmFNyQRlloOfV7SLPU9iwYDKnH
 hxeqxwIGzmiqekWsCnf+kp8lesTrQLWW8TxITOLY+vglyhEzTVzFWoUWwF5rl5T8IxxT
 T+68M10BdQgTLP/IGZR0yhr786s/RfeOZd0V4z3ESmu/KsTFtIIvIo9q2HTFO0QyRY+u
 kXsIvhOEFbITsGw847CEr1lSI96wOnjU6PultHgCJ9ZAdshz4PAJkGxB29K5j4ShkknF
 f6z4H/Kj138jnVg5Em7iyNz9T/fsBbl3vdPmh+qZT1PiUrOfpeT5e9y/N/zUYsAudQSY
 WnFQ==
X-Gm-Message-State: AOJu0YwuDgygZuTwSWWFqEDJIa8JJ6iMamo8YGeLHHgRJZ9izKtZb5Rj
 6TF5I5/2odf9348I0ACC0pI5rtq+FmJCFizH4dCGJq/HFcbgJ6jNO5KzjGm2hTm12mDcVSyTXOK
 8DSoMvymndvAMYNQ=
X-Received: by 2002:a1c:7712:0:b0:401:c52c:5ed9 with SMTP id
 t18-20020a1c7712000000b00401c52c5ed9mr12611542wmi.32.1696845159754; 
 Mon, 09 Oct 2023 02:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiKxcn+QharJqrEncZWbgQDDqzHvclbKwDAaro49/Sfq1NcsbO6TNlv5TfCt56EfTvCAx0Ew==
X-Received: by 2002:a1c:7712:0:b0:401:c52c:5ed9 with SMTP id
 t18-20020a1c7712000000b00401c52c5ed9mr12611518wmi.32.1696845159391; 
 Mon, 09 Oct 2023 02:52:39 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bg24-20020a05600c3c9800b004063c9f68f2sm7512090wmb.26.2023.10.09.02.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 02:52:38 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  jsnow@redhat.com,
 crosa@redhat.com,  kwolf@redhat.com,  hreitz@redhat.com,
 eblake@redhat.com,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>,  Joel Stanley <joel@jms.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,  Halil Pasic
 <pasic@linux.ibm.com>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,  Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,
 qemu-arm@nongnu.org (open list:Integrator CP),  qemu-s390x@nongnu.org
 (open list:S390 Virtio-ccw)
Subject: Re: [PATCH v7 05/15] python/qemu: rename command() to cmd()
In-Reply-To: <20231006154125.1068348-6-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 6 Oct 2023 18:41:15 +0300")
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
 <20231006154125.1068348-6-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 09 Oct 2023 11:52:37 +0200
Message-ID: <87zg0syvfe.fsf@secure.mitica>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> Use a shorter name. We are going to move in iotests from qmp() to
> command() where possible. But command() is longer than qmp() and don't
> look better. Let's rename.

I feel your pain O:-)

> You can simply grep for '\.command(' and for 'def command(' to check
> that everything is updated (command() in tests/docker/docker.py is
> unrelated).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> [vsementsov: also update three occurrences in
>    tests/avocado/machine_aspeed.py and keep r-b]

Reviewed-by: Juan Quintela <quintela@redhat.com>


