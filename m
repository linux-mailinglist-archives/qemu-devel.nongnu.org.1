Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2C7827F00
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:04:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN69P-0008MN-Up; Tue, 09 Jan 2024 02:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN69N-0008Ki-Hc
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:03:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN69M-0004sx-3C
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704783827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwSOsgsk4i25QZZwCttjg3e1aGVb8KlK6ujLEdRNsMQ=;
 b=X96edxRUC96sYqSshxoy4W9YaFHJEbsFopkkWQvhX4+/aYSpL13YSmGboJxqCg7qv/K1et
 lXVNsZWHs1HQF7HQEkB9m4ijlTYQw7Tcc24RGtHvR7vVZ7rBREjTj67dPfsZxDQ+y3fZfz
 DLI6GtpKZUNcfDGmpo4uGhzDQ+Np4g8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-rMbxtQinNBCIVnlmyGG0Nw-1; Tue, 09 Jan 2024 02:03:45 -0500
X-MC-Unique: rMbxtQinNBCIVnlmyGG0Nw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4297db4eba1so29442441cf.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704783825; x=1705388625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vwSOsgsk4i25QZZwCttjg3e1aGVb8KlK6ujLEdRNsMQ=;
 b=sXJ+7fYkkisgSA9toe7HEzh3+tmyheroA4e2r1T4DhV5vI1iSTAeWggEVm5gt4kG/+
 j7Bw9ptX+cAetX8Nn1DhT6N4JAyT4Hdk+Xx/d5XtEf0cV6N4VuRsO8ZOyEpqUAf9OTpH
 h45b7HgLsTHm2bEWg11U9mQgT47E9e7qRRNMsfobLEtHQrvpmH3CdCF/HK7/BLecTBlY
 v44Hhh9I2dOzHlXEaQFYlZKxV7z6EKzNMU1K2ffuQryp4BX9nSMfPNf5KDiatEJfOHJu
 cq19TRatzyHMtTBBhkd2uUvJIkB2feu+kPWfHFNEl0I/7VFlc47xS4z4o+tRfjHiMAYE
 W8Xw==
X-Gm-Message-State: AOJu0YwFcFmCQRJO79ULwScBv5CnpQ6OFhtoeaaGnd8XFfflbjMh/+cO
 nqKUliO0u8ogI3H8u0g4AwfIAQLmyPKc0c/DxW4CtQVPrFUzb6bS/PfpUI3im8OZGPvMGJP5Qzz
 bR3wk3l1LqexA4Aa3vz1uFus=
X-Received: by 2002:a05:622a:1a25:b0:429:987d:15ae with SMTP id
 f37-20020a05622a1a2500b00429987d15aemr2365512qtb.15.1704783825221; 
 Mon, 08 Jan 2024 23:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKLx8uJNM98M1/EXeee0gtif6XGeckz67t8wBGCOIIUv20LzjEkvcCNuZbk+yfdU2LOvuevA==
X-Received: by 2002:a05:622a:1a25:b0:429:987d:15ae with SMTP id
 f37-20020a05622a1a2500b00429987d15aemr2365508qtb.15.1704783825022; 
 Mon, 08 Jan 2024 23:03:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 cr14-20020a05622a428e00b0042997333149sm605370qtb.63.2024.01.08.23.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 23:03:44 -0800 (PST)
Message-ID: <6a7102c6-72f8-4090-83b3-9e3f70f2aa76@redhat.com>
Date: Tue, 9 Jan 2024 08:03:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] docs/migration: Split "Backwards compatibility"
 separately
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-5-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/9/24 07:46, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Split the section from main.rst into a separate file.  Reference it in the
> index.rst.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




