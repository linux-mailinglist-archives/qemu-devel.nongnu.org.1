Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA97729EE8
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7clF-0000rA-P5; Fri, 09 Jun 2023 10:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q7cl9-0000qa-UJ
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q7cl7-0008KR-QL
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686319591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w68Gb+6wjxy8mGU5IAVZ/yYNWDeAAOE0hY6FdEu6oqI=;
 b=jFy1u/Pi/qE9CHcO1t7BBPqLYVyCm4dxd+V2/K7K7tWVHKkc+6B59uh4nw+gJrmTmVrxe4
 XZ9yZEoRt/tiOiiYRSoWQDa+OvFXa6fqOoMwzX4pNfEZlfjvInG0G0IK4W1+bx48h479W3
 +hm798/iXPGL0dvSmFx1BIr8EIvsIMA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-EhvlTRn2On-wQK7UvF4Ftw-1; Fri, 09 Jun 2023 10:06:29 -0400
X-MC-Unique: EhvlTRn2On-wQK7UvF4Ftw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso147921266b.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 07:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319587; x=1688911587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w68Gb+6wjxy8mGU5IAVZ/yYNWDeAAOE0hY6FdEu6oqI=;
 b=NXMPTdvoRleNs22UFCKDMZFX11e4O6bqGELTaWVAhv6kLAo9zadNEv8h1j4nHpkiQh
 Po8wriZ24nlgaCqeoSCJ0UrsRiWmRE/00Nn6SZFrNrbe4WAxvuhfH8RUHVXvoC4Ze6wy
 rDehZ9++hk5UeqHJ1bfSFvyvNsjHhJlGlnfAm8RFg/GNoFTNRSU02JMlKrCc7CRfRKSW
 9JSIcDr5mK3mEtDzrf/NQDv02c6Z7PMSnN5wR7s18PH/0R1zqK3sFw8OOH/THLzvy0nV
 LwxsLiDqrIo2TpT0vV+QNG+Qoelog3sjv0uyZ5zVZ9ERwH5rjbw1xkDx90bI+bjy6zP8
 6yeg==
X-Gm-Message-State: AC+VfDx2B0lfk+7oJuHrsxnzsuYF/C5ctZxK8/PeCMK38MtfsEj80Nlp
 Ul4AH2xwLk3UtcJ8mzcZacX01DJa2INTiwayIdEhYYalvJEV6alaczABXSephmfklnpy/BgPYPv
 O0phg3jF8lz9pTvvad+DJbQf7j82FnzKvx8/9eyC9YZEYXGDPzL1UZa195g+7KIKZ3tUegEhEQa
 o=
X-Received: by 2002:a17:907:3da3:b0:971:eb29:a086 with SMTP id
 he35-20020a1709073da300b00971eb29a086mr1906459ejc.75.1686319587595; 
 Fri, 09 Jun 2023 07:06:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AihuzTjKEhhhqfAY2V8rctQNq2kLJVg2Zj1mDwMlCpASHEkYaLGNOcko5Ve97t7/RsErljA==
X-Received: by 2002:a17:907:3da3:b0:971:eb29:a086 with SMTP id
 he35-20020a1709073da300b00971eb29a086mr1906433ejc.75.1686319587229; 
 Fri, 09 Jun 2023 07:06:27 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 u20-20020a170906781400b009764f0c5fe6sm1362760ejm.7.2023.06.09.07.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:06:26 -0700 (PDT)
Date: Fri, 9 Jun 2023 16:06:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, wangyanan55@huawei.com,
 thuth@redhat.com
Subject: Re: [PATCH] machine: do not crash if default RAM backend name has
 been stollen
Message-ID: <20230609160625.3cb92853@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230522131717.3780533-1-imammedo@redhat.com>
References: <20230522131717.3780533-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 22 May 2023 15:17:17 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

Paolo,
can you pick it up?

> QEMU aborts when default RAM backend should be used (i.e. no
> explicit '-machine memory-backend=' specified) but user
> has created an object which 'id' equals to default RAM backend
> name used by board.
> 
>  $QEMU -machine pc \
>        -object memory-backend-ram,id=pc.ram,size=4294967296
> 
>  Actual results:
>  QEMU 7.2.0 monitor - type 'help' for more information
>  (qemu) Unexpected error in object_property_try_add() at ../qom/object.c:1239:
>  qemu-kvm: attempt to add duplicate property 'pc.ram' to object (type 'container')
>  Aborted (core dumped)
> 
> Instead of abort, check for the conflicting 'id' and exit with
> an error, suggesting how to remedy the issue.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> CC: thuth@redhat.com
> ---
>  hw/core/machine.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 07f763eb2e..1000406211 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1338,6 +1338,14 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>          }
>      } else if (machine_class->default_ram_id && machine->ram_size &&
>                 numa_uses_legacy_mem()) {
> +        if (object_property_find(object_get_objects_root(),
> +                                 machine_class->default_ram_id)) {
> +            error_setg(errp, "object name '%s' is reserved for the default"
> +                " RAM backend, it can't be used for any other purposes."
> +                " Change the object's 'id' to something else",
> +                machine_class->default_ram_id);
> +            return;
> +        }
>          if (!create_default_memdev(current_machine, mem_path, errp)) {
>              return;
>          }


