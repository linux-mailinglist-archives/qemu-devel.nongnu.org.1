Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B907C70D87F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 11:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1O2c-0008Gk-EF; Tue, 23 May 2023 05:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1q1O2P-0008EA-V9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 05:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1q1O2O-0001Y0-0f
 for qemu-devel@nongnu.org; Tue, 23 May 2023 05:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684833032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2r754DdZckZ4GsbKofnpXF8CyFQdJnxIBzC/fgruQg=;
 b=ACeXzjnsPizSLWb9JNHfP2aGADeXPbt/74KF/mRMH4oGODkS7pRyLmGPuHKPTr3+ed8DCK
 WgzbBCdgPnxt+rYoLDtbnSPRIxDmg4XFyFnfOBjI1xQuEgAu9dXW7FyvpUF+JcORQ3FZ0e
 Nj+3SsHF44M+5BZpJVaWGTMdRoLg5ao=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-kHdbzIYrNuSc6aanJhtP5A-1; Tue, 23 May 2023 05:10:31 -0400
X-MC-Unique: kHdbzIYrNuSc6aanJhtP5A-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ae7839ea42so3494395ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 02:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684833030; x=1687425030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W2r754DdZckZ4GsbKofnpXF8CyFQdJnxIBzC/fgruQg=;
 b=RfAUvRpzqaY63kPiWvlT4VevZDKG+/Y/IgKrqNcC3bV1nc3DHrlLqgU9szIY2taQs+
 iVANFFFotoReRs398YeOIM7a7x9QaRvtV5/YQV1L7DsmGVq5TqMepIoTNDYyZKtlfaaI
 hupKY9bhUU8+x/h9fD8s1+6xqXliGbcL2MZ9j+j4GYeR7h7xXJZJPILpTeXeZzbQzZM8
 5As1CQLF4Uau8I2NvkoNxK5cpg8vX0pX85WSbcsJjs/8Sv6N/F3mj+FG7Woc108onYgl
 HkOdlBG5XiiTjfrmpEDVWmP+lDk11IVwnB6z6gqK9TUL+CZtbSQco5/LaXEWKjIvG23e
 aJsA==
X-Gm-Message-State: AC+VfDw5qOO/MRuxu7Yb7OICQGwctQzXgKab4BgxbxiDwwc+LiC8VLoH
 XinZzuc3HaTnvRe3SJ/t67xCbQeRByjd77kK145j6KryGSFsCLEHde4TVOWBrDEtH7bDqIQMYZd
 waDjXG48aGKvJQsPS08gurW476kzBmzLrdhXFmiWnS/0eQosZAVDck+FMLkOZsZqWIhqDAOcusc
 mRDFEH
X-Received: by 2002:a17:902:daca:b0:1ad:eada:598b with SMTP id
 q10-20020a170902daca00b001adeada598bmr15259094plx.3.1684833030036; 
 Tue, 23 May 2023 02:10:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dB+2Viq6EPzTEYGIM8SSjzr55k5AQsbiNPUWUKhjBBZ6QMJAbirkEz8KdlM+XYsAxNZ5uTw==
X-Received: by 2002:a17:902:daca:b0:1ad:eada:598b with SMTP id
 q10-20020a170902daca00b001adeada598bmr15259076plx.3.1684833029659; 
 Tue, 23 May 2023 02:10:29 -0700 (PDT)
Received: from [10.66.61.39] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a170903018500b001ae5044c2aasm6262139plg.145.2023.05.23.02.10.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 02:10:29 -0700 (PDT)
Message-ID: <224df307-6eb2-9719-d3f4-851af428392c@redhat.com>
Date: Tue, 23 May 2023 17:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] machine: do not crash if default RAM backend name has
 been stollen
To: qemu-devel@nongnu.org
References: <20230522131717.3780533-1-imammedo@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20230522131717.3780533-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

With the patch, qemu exits normally instead of Aborted.

On 5/22/23 21:17, Igor Mammedov wrote:
> QEMU aborts when default RAM backend should be used (i.e. no
> explicit '-machine memory-backend=' specified) but user
> has created an object which 'id' equals to default RAM backend
> name used by board.
> 
>   $QEMU -machine pc \
>         -object memory-backend-ram,id=pc.ram,size=4294967296
> 
>   Actual results:
>   QEMU 7.2.0 monitor - type 'help' for more information
>   (qemu) Unexpected error in object_property_try_add() at ../qom/object.c:1239:
>   qemu-kvm: attempt to add duplicate property 'pc.ram' to object (type 'container')
>   Aborted (core dumped)
> 
> Instead of abort, check for the conflicting 'id' and exit with
> an error, suggesting how to remedy the issue.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> CC: thuth@redhat.com
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   hw/core/machine.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 07f763eb2e..1000406211 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1338,6 +1338,14 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>           }
>       } else if (machine_class->default_ram_id && machine->ram_size &&
>                  numa_uses_legacy_mem()) {
> +        if (object_property_find(object_get_objects_root(),
> +                                 machine_class->default_ram_id)) {
> +            error_setg(errp, "object name '%s' is reserved for the default"
> +                " RAM backend, it can't be used for any other purposes."
> +                " Change the object's 'id' to something else",
> +                machine_class->default_ram_id);
> +            return;
> +        }
>           if (!create_default_memdev(current_machine, mem_path, errp)) {
>               return;
>           }

-- 
Shaoqin


