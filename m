Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06280786154
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:22:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuMz-0005wL-AI; Wed, 23 Aug 2023 16:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuMx-0005nM-1w
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuMv-0005FG-KQ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692822141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g4R2ahnxtehW79MVxpyfS53s2T7FU3KxpkpGvpPoogc=;
 b=VhhtB/0cHYchtGOJSEgQ1r6U4IWRkLcV4xqL4MvoXMXulmF6P+cpxtYbXtNmY8LPMUeM94
 V/tedKG5Wg1mLv493xxdOBEnBi71soPzb7CuveFO+HRRUMBsgZPdFw6SJAKW3VMLNdAUnh
 H5L1nwAtNYs6+Zds2GHlRlvdn/2BDOI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-iQcIJEW5MVmRC-XondYeQg-1; Wed, 23 Aug 2023 16:22:19 -0400
X-MC-Unique: iQcIJEW5MVmRC-XondYeQg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-64f54ababd1so4123566d6.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822139; x=1693426939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4R2ahnxtehW79MVxpyfS53s2T7FU3KxpkpGvpPoogc=;
 b=W5DbyAPaosdybEXt96uRYnEDo+Mek1l23pl9L810D5OIWBmVkJx68gZG8S859CijzY
 oN4qxK6C9qykNQpeKWYNdc9j7Hh8ugtzFJo7haX6bbbvPH8zTKHo54JqO3r7xSXfQ/ca
 kiZAeZqHjT7gKOiuZPGcF+DOUyjwwCAP5cV4y8eh5PSLzy8be2tkL2ruSoRJfArDfQfH
 LgehDOehsOYDArjqZ5vibCcOInOA1tnj896XsHEXYrDBYkwPs+zubSrk2F2MjFokX8Vr
 nHh1v5W+3356iqbhlkEmne391/MYDEi/5V+VYaIbm/RB9wNPEp/kwJH6Hr0ZXJyUfSZS
 44OA==
X-Gm-Message-State: AOJu0Yx+fZGW84i8ZpXGqGbQy2B7bojZOMxtB8mQNiKxkA4xD+4pBrS9
 /XPwNV9SU5Bn//SFg3D1LwkTkCwcPCaIq60VeUiAiXVxA5BFEo22XNLPKzrD0yenYj4JaY4SW1q
 AO4i1x5hnSD7VPrY=
X-Received: by 2002:a05:6214:5098:b0:63d:2a0b:3f91 with SMTP id
 kk24-20020a056214509800b0063d2a0b3f91mr15635127qvb.2.1692822139359; 
 Wed, 23 Aug 2023 13:22:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfM/9duN1Jeo41iBLNbtDb/SVem0ISq2HH96zJVha+Cqn59panYHKZtloa/aXclafvxkwFmA==
X-Received: by 2002:a05:6214:5098:b0:63d:2a0b:3f91 with SMTP id
 kk24-20020a056214509800b0063d2a0b3f91mr15635103qvb.2.1692822139129; 
 Wed, 23 Aug 2023 13:22:19 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g25-20020a0caad9000000b0063d5c9de720sm448453qvb.80.2023.08.23.13.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:22:18 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:22:16 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 07/11] softmmu/physmem: Never return directories from
 file_ram_open()
Message-ID: <ZOZqeBInVdNpGZEo@x1n>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823153412.832081-8-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 23, 2023 at 05:34:07PM +0200, David Hildenbrand wrote:
> open() does not fail on directories when opening them readonly (O_RDONLY).
> 
> Currently, we succeed opening such directories and fail later during
> mmap(), resulting in a misleading error message.
> 
> $ ./qemu-system-x86_64 \
>     -object memory-backend-file,id=ram0,mem-path=tmp,readonly=true,size=1g
>  qemu-system-x86_64: unable to map backing store for guest RAM: No such device
> 
> To identify directories and handle them accordingly in file_ram_open()
> also when readonly=true was specified, detect if we just opened a directory
> using fstat() instead. Then, fail file_ram_open() right away, similarly
> to how we now fail if the file does not exist and we want to open the
> file readonly.
> 
> With this change, we get a nicer error message:
>  qemu-system-x86_64: can't open backing store tmp for guest RAM: Is a directory
> 
> Note that the only memory-backend-file will end up calling
> memory_region_init_ram_from_file() -> qemu_ram_alloc_from_file() ->
> file_ram_open().
> 
> Reported-by: Thiner Logoer <logoerthiner1@163.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


