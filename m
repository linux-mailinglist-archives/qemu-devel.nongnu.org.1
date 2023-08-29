Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E934C78C055
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 10:34:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qauAq-0001zL-Ut; Tue, 29 Aug 2023 04:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qauAn-0001y2-KW
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qauAk-0001z2-R6
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 04:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693298041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aXWjGzmDC32xRmgn1ivatB0RWpG4DACBOFGSi/skEqM=;
 b=b0C3ez1hwMN57P8nq7d/WMxjAmBsI68w27mGGyift1n1n9XmqdTTW+4m3FoSlSFbTkKMOE
 g8E8W9Q301L8DQeZ8GqQ9qsk+A1RPUTWzxNevssjOcNBH2Lb1ViI6ZSmxImDOCI+0aZWOA
 vUMF7/zuv7DMiS+i38eNnl0Y1O1WQ00=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-53ITeSHiPX28BdSxXBkp2Q-1; Tue, 29 Aug 2023 04:32:06 -0400
X-MC-Unique: 53ITeSHiPX28BdSxXBkp2Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bd1687c5d2so11774501fa.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 01:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693297925; x=1693902725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aXWjGzmDC32xRmgn1ivatB0RWpG4DACBOFGSi/skEqM=;
 b=IGHahNPeoFdHHAKBWwiMC+TAjimc821j+ep3dRfS4GtcwU0Q0I/m06MWCQMtGM6t9c
 Juux3OiZlYO+K/Z4+Ni8Gqr5fIMZKQUC1os9/KoB40Pg83zcwZOHqXOhRzPzZ7s+GmbJ
 Mk4OHt0+8t+i3RMQlVye6UwMKMWZQipHh4bvkB/FWpjTHSEpIUuylXvfccVWtUi7CxwD
 c4SnIZ/pqDRz7lFACRbfmXvjDfm/5bbMr7dwp2n//9ljlUFmdbBCp+0v/xbvpRw7ZkPW
 q7UVeAVE0IahvRoXGMUZ0v8nT7dROHvp+/punZdMb2xuqnHS96YRCzdZxdgnfy0WzX5r
 9Lkg==
X-Gm-Message-State: AOJu0YxeuUH1gLaASORrLslQ4G98flOuGvfa02Z/SK+fbxYGcINRMeWU
 8lcmta1/JRUIFKpwnMahuTvnBaYVEBoXjUN8nwci9aEMrM+C0NYeRN4hK8mCCoDbmo6gWoMcQHl
 I2qvTdsedJ6wiqhjZHIRkdUAIiKi2BOs=
X-Received: by 2002:a2e:999a:0:b0:2bb:8bc1:db55 with SMTP id
 w26-20020a2e999a000000b002bb8bc1db55mr19342334lji.52.1693297925272; 
 Tue, 29 Aug 2023 01:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4tg3qSUue023fkl767evJtL1wFp3Oo6ZV8qs7AwqlULwQHFKhdIL2yBMY9xe/QvEo813S0Qx4nXJCw6t+UUk=
X-Received: by 2002:a2e:999a:0:b0:2bb:8bc1:db55 with SMTP id
 w26-20020a2e999a000000b002bb8bc1db55mr19342303lji.52.1693297924811; Tue, 29
 Aug 2023 01:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-12-david@redhat.com>
In-Reply-To: <20230823153412.832081-12-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 29 Aug 2023 10:31:53 +0200
Message-ID: <CAMXpfWvNr9tjciWXYHCSdh=r0jae_hjFJoo_s2iAJvqND-5Q6Q@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] machine: Improve error message when using
 default RAM backend id
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series has been successfully tested by QE. Start a vm using
pc.ram id but specifying a different memory-backend from the default
one. Check the error message has been improved.

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Wed, Aug 23, 2023 at 5:38=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> For migration purposes, users might want to reuse the default RAM
> backend id, but specify a different memory backend.
>
> For example, to reuse "pc.ram" on q35, one has to set
>     -machine q35,memory-backend=3Dpc.ram
> Only then, can a memory backend with the id "pc.ram" be created
> manually.
>
> Let's improve the error message.
>
> Unfortuantely, we cannot use error_append_hint(), because the caller
> passes &error_fatal.
>
> Suggested-by: ThinerLogoer <logoerthiner1@163.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/core/machine.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f0d35c6401..dbcd124d45 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1382,7 +1382,9 @@ void machine_run_board_init(MachineState *machine, =
const char *mem_path, Error *
>                                   machine_class->default_ram_id)) {
>              error_setg(errp, "object name '%s' is reserved for the defau=
lt"
>                  " RAM backend, it can't be used for any other purposes."
> -                " Change the object's 'id' to something else",
> +                " Change the object's 'id' to something else or disable"
> +                " automatic creation of the default RAM backend by setti=
ng"
> +                " the 'memory-backend' machine property",
>                  machine_class->default_ram_id);
>              return;
>          }
> --
> 2.41.0
>
>


