Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F15730444
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 17:55:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Spo-0001Ul-Rq; Wed, 14 Jun 2023 11:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Spn-0001TB-84
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9Spl-0003Mj-Td
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686758097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STJT693hF7VU2h4xpkOtlRH5uzk7tPdEaMa7Ev5YlUQ=;
 b=h/wxLahOYsksQ9hxjvHF246abUQlMiQ7OUNUcj5sNU3pHX5NYid9VgFKCClyfy1UXZQ2hv
 79EguG7ccjI6uPX0jlgWRS1s+oG2Nme0YgEjiG6AmlrtKT5TSAT05pDI/I4QD8c0dilcfI
 GIx4KnLreCP3AMagXt7bBr9ZYOm33G4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-9GeSSGnPOnGYuVWbSjeECA-1; Wed, 14 Jun 2023 11:54:53 -0400
X-MC-Unique: 9GeSSGnPOnGYuVWbSjeECA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75ec91f26c8so149699785a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 08:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686758093; x=1689350093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STJT693hF7VU2h4xpkOtlRH5uzk7tPdEaMa7Ev5YlUQ=;
 b=GW7xr4kQ4QN81Stbm7ENicshy9IVCyq37N7C/elEUGYYpu/HMp6H0tbWQlFKayPnd0
 C2SkgSoz9X+8leqfcX27cmBzbSOHZ6R2n7Wzyy1QM5d20m0DIEvoln0EQL3v1twMndyb
 1oUCdIIIjzK1j3Z5EnEdjmKd4m7bz1AHwDMWlS3R7hqGseK05Gxb43y4tZe4yj/y9gvE
 SJ5SubswhkxrgPA2tXh7erVfeScI0NOB5Q2i1BlhODz631fkkA3DMzMpSV+9NVcac6wj
 mQ6AEM9iSS68Htf3ddKuGPzd3+68e5170vLf/Rbqa2DE6CyuUUEjbcPCMtAQ1a2zu0mJ
 GWcw==
X-Gm-Message-State: AC+VfDw83KMVPILOd2bl0AFGI2VQ6Nk6D8XBEh5WiKQh0p7qE8kU5WNP
 g3Owi/6hn1pGtZ2ZBD5/Zz6ioljBGpAe8CcOBjzVHxE6jybjmpDFPm/OtOyquanwKZqupWUv/vh
 /1R1dyKRvxV+UQ10=
X-Received: by 2002:a05:622a:1a8c:b0:3e2:be32:cb74 with SMTP id
 s12-20020a05622a1a8c00b003e2be32cb74mr20423599qtc.3.1686758092808; 
 Wed, 14 Jun 2023 08:54:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FJLwcJtHctsT51RsZqMmRgUUo+kbPBInaugzSRLB33UkQcoW4PwCCUZT42TruJZNI+G4wVg==
X-Received: by 2002:a05:622a:1a8c:b0:3e2:be32:cb74 with SMTP id
 s12-20020a05622a1a8c00b003e2be32cb74mr20423588qtc.3.1686758092604; 
 Wed, 14 Jun 2023 08:54:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f8-20020ac84648000000b003f9cca00552sm5038862qto.93.2023.06.14.08.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 08:54:51 -0700 (PDT)
Date: Wed, 14 Jun 2023 11:54:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 20/20] qemu-file: Make qemu_file_get_error_obj() static
Message-ID: <ZIniyk9Xt6l19Ky6@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-21-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530183941.7223-21-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, May 30, 2023 at 08:39:41PM +0200, Juan Quintela wrote:
> It was not used outside of qemu_file.c anyways.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


