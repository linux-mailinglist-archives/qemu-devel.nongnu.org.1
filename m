Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 320AD70DD4F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RsG-0004Z9-St; Tue, 23 May 2023 09:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1RsF-0004Yg-20
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1RsC-0002pA-Hl
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684847778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWP3+NJ1QhwBJ9mLEQV9arNV8ZasZn1ZAADKzpOMDPg=;
 b=etDdKpsTt1Qxmawckw11lS3UYLVafHGtchygSBVz7/h1TFE5+mpGdP1ILgf3tnkwGasXV3
 EzWJkELsSdi7nJhtYvXZK7zsXwWLCEtM0UjFOQC0MWaG7m5BpLX8HzFYS7QX/VW1Si/eZq
 RIa/mr+8xG3J8PGmFWJvTp9y1y6L8H4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-555CJ6T7P8Wgs3NM0wS4Aw-1; Tue, 23 May 2023 09:16:16 -0400
X-MC-Unique: 555CJ6T7P8Wgs3NM0wS4Aw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f604687a23so9779505e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684847775; x=1687439775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mWP3+NJ1QhwBJ9mLEQV9arNV8ZasZn1ZAADKzpOMDPg=;
 b=RoBtR3BP8jvZV4e0oeHHrprjLJi3G339f3HO2+GRryUK9YWrKM80OeWfNBKMPtTLDa
 /PLiThlvsk1nmwl940fFv5fS0oCNId6mu61o/g6h17s+qq+lv27lyHsUSP8OPQaxtbmF
 8hPT5oPEnJg8v/a0G4PJRwgEu/rKidHV2Ja9hwFDeYK3whotVftDl6oEdSB1G/++1+UC
 P29b3McPMfjGjuYnH10srzzRt5oDugHJ8p0z+ZZI+YWXtE6inA10150ZuNpBW545TYA/
 wmbRYDl0E2zf2hdDWnSUzwx1eB1KL8t7fypDjMOI5ZQ3Br6D7Ezb3RIN8v7VEqXAAix5
 0rMQ==
X-Gm-Message-State: AC+VfDy6CrQ09LVIIb4NFo//hYpYMAueDaQAtqcG0Fw5qn+Ecll1T556
 zAz7R4RZArSrU4aI9+YA4V11dlaAe03joLxf2ohoE9Wu7zqcPq00vPIkdcBrPtHIPJcZHySI7rZ
 /pSOT0OdkblEsJrA=
X-Received: by 2002:a5d:4b89:0:b0:309:4620:e155 with SMTP id
 b9-20020a5d4b89000000b003094620e155mr9269357wrt.49.1684847775768; 
 Tue, 23 May 2023 06:16:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KnyTgho5qNuiD2x/hwQj1UxyHIjwiDnMPgijgwAA9P9kzp6AVnh/IzT6GnCOUobRBAHCwlw==
X-Received: by 2002:a5d:4b89:0:b0:309:4620:e155 with SMTP id
 b9-20020a5d4b89000000b003094620e155mr9269337wrt.49.1684847775452; 
 Tue, 23 May 2023 06:16:15 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 w13-20020adfd4cd000000b0030497b3224bsm11003855wrk.64.2023.05.23.06.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 06:16:14 -0700 (PDT)
Message-ID: <08527812-8a68-0ff5-463d-76e490c12be9@redhat.com>
Date: Tue, 23 May 2023 15:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] machine: do not crash if default RAM backend name has
 been stollen
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, wangyanan55@huawei.com, pbonzini@redhat.com,
 Markus Armbruster <armbru@redhat.com>
References: <20230522131717.3780533-1-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230522131717.3780533-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


s/stollen/stolen/ in the subject

On 22/05/2023 15.17, Igor Mammedov wrote:
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

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2207886

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> CC: thuth@redhat.com
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

Works for me on s390x, too (see 
https://bugzilla.redhat.com/show_bug.cgi?id=2207886#c3 )

Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>


