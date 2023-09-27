Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B87AFE59
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 10:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlPsi-0007N8-5f; Wed, 27 Sep 2023 04:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlPsf-0007Me-TH
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlPse-0006N5-2y
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 04:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695803207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygUANsCCpAlUIPcL/gDf040dCRhoERvWC6av9X/3CuU=;
 b=FrHKcEXis9a2mJcnFdtPbT16aqN3DgZ+HEgN8k/UjiLplYaSrugX/x6ZwXS/2OzfJ3DLWT
 YT06pwMbFC3Fnw0NikF9Cz3llL8up5vIa06TX4lgG2Qb1J/mFJ87WxS+elOW36nlKSa+Lg
 bfFfmxJfy2Ml0Lu9UHz4MoTLX4P8WuM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-p4sjtv-3OSWvJxxTzacVcw-1; Wed, 27 Sep 2023 04:26:45 -0400
X-MC-Unique: p4sjtv-3OSWvJxxTzacVcw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-417f9e1def0so162152301cf.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 01:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695803205; x=1696408005;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ygUANsCCpAlUIPcL/gDf040dCRhoERvWC6av9X/3CuU=;
 b=Q+GiCfYpeGk/Lgd9nwvgM04EYHZMxs3WK99TIWKgPK4HiLFn5qH0ZQHdumx5TU2G66
 aLeURyEdaQkJByJx09P4OUelEryxi9yonS80LJpRh5ALfqcdqFvEY8P/SOT6CsF5Rgxm
 7KGkvnShGOEwyVe5oXJIDTCDx6toshFKWohvsLuxz1+TeRAsveXzNui7qL9WRR0Ghum9
 X1NVb+gF0be0GsGGbJbXzs4hgm2sqhpD3p++lHUYCMwFGQlraqpJtJ0Im0B4GOf6blN1
 73PzHr9xlItHZv5DtFumRCXv3d1mtX4OONLdmgm2vhjODGaXE160leYXYyIYRkn0ptB2
 10Zw==
X-Gm-Message-State: AOJu0YxS7ioKGmDHQA0BHaZ5u6C9kbZfbXnb3y1KQy9vPHXmsn6CSctx
 lNKzBOkHAa1W8ejaRx/QECHcaVofVeqQB4dmYbEbTTtPCoMO/SAs4oOcQL+YcbVKxDrNu4JcCCe
 0YL9in4p+OK0JcKs=
X-Received: by 2002:a05:622a:4d4:b0:419:57b9:e92 with SMTP id
 q20-20020a05622a04d400b0041957b90e92mr1361912qtx.8.1695803205427; 
 Wed, 27 Sep 2023 01:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz2qVsb5pO3rMPr1Xv4XHP9vcieR6KfoO8HCZmFNWJDjkJJ3tfMUYNBzmBBUHMa5G8dwv99w==
X-Received: by 2002:a05:622a:4d4:b0:419:57b9:e92 with SMTP id
 q20-20020a05622a04d400b0041957b90e92mr1361902qtx.8.1695803205132; 
 Wed, 27 Sep 2023 01:26:45 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-22.web.vodafone.de.
 [109.43.178.22]) by smtp.gmail.com with ESMTPSA id
 c17-20020a0cca11000000b0065b21f1b687sm1515099qvk.80.2023.09.27.01.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 01:26:44 -0700 (PDT)
Message-ID: <353ea6dc-bec2-92e9-5452-8ea675e75a63@redhat.com>
Date: Wed, 27 Sep 2023 10:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] scsi-disk: ensure that FORMAT UNIT commands are
 terminated
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
 <20230913204410.65650-4-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230913204410.65650-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/09/2023 22.44, Mark Cave-Ayland wrote:
> Otherwise when a FORMAT UNIT command is issued, the SCSI layer can become
> confused because it can find itself in the situation where it thinks there
> is still data to be transferred which can cause the next emulated SCSI
> command to fail.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Fixes: 6ab71761 ("scsi-disk: add FORMAT UNIT command")
> ---
>   hw/scsi/scsi-disk.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index e0d79c7966..4484ee8271 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1958,6 +1958,10 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
>           scsi_disk_emulate_write_same(r, r->iov.iov_base);
>           break;
>   
> +    case FORMAT_UNIT:
> +        scsi_req_complete(&r->req, GOOD);
> +        break;
> +
>       default:
>           abort();
>       }

Thanks! I just double-checked that this fixes the crash that can be 
triggered with the reproducer from 
https://gitlab.com/qemu-project/qemu/-/issues/1810 :

Tested-by: Thomas Huth <thuth@redhat.com>


