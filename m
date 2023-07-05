Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC771747EBB
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 09:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxOy-00064l-Dt; Wed, 05 Jul 2023 03:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGxOv-00061o-6h
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGxOt-0003gX-OA
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688543891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DHyUUWj6BrRpeBXtGyi+Vo8u/2b6hcAsHGdukza2YEg=;
 b=gXu8IAR4q7e1wkrF4N5PY8CB4U1kZv9ZvY2GWCzl7NZgf6/UNaoekw0jDOB7yFIk1CsnxC
 wlc8ghOmcW+L2z+c5vtqhsFh6D9USMn/xr16jDQb/3nyICFztPa0uEQRsW/EQ4mj4EMQvO
 aXNMKBGpVZYsYtF7/TKPi7MsoHSdFPs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-26rBT3NDOGuATGX4IymZ3w-1; Wed, 05 Jul 2023 03:58:09 -0400
X-MC-Unique: 26rBT3NDOGuATGX4IymZ3w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-40349e4eb27so32073291cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 00:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688543889; x=1691135889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DHyUUWj6BrRpeBXtGyi+Vo8u/2b6hcAsHGdukza2YEg=;
 b=Bxcbj3yfTPcK12RTowF1mqUA7sv493wHgS16RWrfcIyseJzvZ8ej7SuGpkaTAF1r93
 8+LTX47/4oDpm3RLAHtpt1WlcQbBdE3DnqPIjqQ1vqVWKTXGEizim5Uo/U4/asrtAhZS
 tsntR6Dx8dh7zIoUv78Zwkx0GM42D088dbQ3ZWMvjNaOWEn9SCGbRP2Uu9ReXTMJxcm+
 2daks/mJEUUoDSyfwQxUV++MpIbhI9iNz6y2L81/5CxMrvIcQX0rUlQay/T2HDvZcFa2
 av+lUzfMtLSj5d87UO0WPt9cMZkKSsd8kxeUWV84wachBFCRetiEhiYp15NoaBwMl+34
 KKSQ==
X-Gm-Message-State: AC+VfDyUcAX/AanwdVW+FtcIGnle2VwkNyO5L1sRX3dOh08eCztDeRm/
 wBryUZj/Hy/EWL8vYnybZxPltNwotDAuPNTdoDlE8w12up5ltinLlFarkaVgSx+LFmAOh/vHw8k
 NDrr+5lcgxjviRV4=
X-Received: by 2002:ac8:7e95:0:b0:400:a9db:f0cb with SMTP id
 w21-20020ac87e95000000b00400a9dbf0cbmr17119498qtj.12.1688543889323; 
 Wed, 05 Jul 2023 00:58:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VuOMVWA8XBvaJxR0q5M6RwQbAsHqqk0YDI9u2J8ujXYh0h4xbzBgwyDXuEmGGcn2BnoZROQ==
X-Received: by 2002:ac8:7e95:0:b0:400:a9db:f0cb with SMTP id
 w21-20020ac87e95000000b00400a9dbf0cbmr17119485qtj.12.1688543889007; 
 Wed, 05 Jul 2023 00:58:09 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 j11-20020ac85f8b000000b003fdec95e9c8sm7613863qta.83.2023.07.05.00.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 00:58:08 -0700 (PDT)
Message-ID: <3d4d0349-45c1-28c7-1da1-3c66f03025a0@redhat.com>
Date: Wed, 5 Jul 2023 09:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 12/20] qapi/s390x/cpu topology: query-cpu-polarization
 qmp command
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-13-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-13-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/06/2023 11.17, Pierre Morel wrote:
> The query-cpu-polarization qmp command returns the current
> CPU polarization of the machine.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   qapi/machine-target.json | 29 +++++++++++++++++++++++++++++
>   hw/s390x/cpu-topology.c  |  8 ++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 1362e43983..1e4b8976aa 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -445,3 +445,32 @@
>     'features': [ 'unstable' ],
>     'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
>   }
> +
> +##
> +# @CpuPolarizationInfo:
> +#
> +# The result of a cpu polarization
> +#
> +# @polarization: the CPU polarization
> +#
> +# Since: 8.1
> +##
> +{ 'struct': 'CpuPolarizationInfo',
> +  'data': { 'polarization': 'CpuS390Polarization' },
> +  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
> +}
> +
> +##
> +# @query-cpu-polarization:
> +#
> +# Features:
> +# @unstable: This command may still be modified.
> +#
> +# Returns: the machine polarization
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'query-cpu-polarization', 'returns': 'CpuPolarizationInfo',

Since this is very specific to s390x, I wonder whether we want to have a 
"s390x" in the command name? 'query-s390x-cpu-polarization'? ... or is this 
getting too long already?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


