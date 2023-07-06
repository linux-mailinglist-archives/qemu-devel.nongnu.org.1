Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FF749BAB
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:28:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHO5F-000585-5G; Thu, 06 Jul 2023 08:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHO5B-00057t-KK
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHO56-0003cG-Qx
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688646451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlaVNRrGF1d0U1V+NW776j6TO/AOcvlNopcJTX0Ta84=;
 b=ig1ItPEGFuQMWPsbreCKeFj3hIOpna1viSzHCeWX2yAv3crdAorF9MRdxZ/xyC+uUGQhNB
 UlOMLIv7Kieki/dz8RGWdLJglec6kRBdZEHW+f3IAcuWsF8tWv+Of7tr9t+H8znZlSHaSG
 SOSLpMDSfVcN8fAbkp2e2Dds3CTtcWs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-RsNOFaCkNLmF9-ZC1dZTVw-1; Thu, 06 Jul 2023 08:27:30 -0400
X-MC-Unique: RsNOFaCkNLmF9-ZC1dZTVw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63656624620so1540506d6.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 05:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688646450; x=1691238450;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zlaVNRrGF1d0U1V+NW776j6TO/AOcvlNopcJTX0Ta84=;
 b=JB210xbVTtUZpjNGIg0TFrxwR0riDF3gFQbBiGhvK35VnUGJ5fuEBDEW02Yl1Xvbz4
 eLxjQFp5hb3rY2VIBFOWPMlTWSxJL5+X/JgYTgpeW2FXq5vpyEDKYiLLG0H5bEv5tW/W
 AsH2wT2EiIGGlE3QHkYieGIpOUIJCdzgNCbBDp9qniXn13GVdlfzySJ18VCi1aue8VP/
 tn1L3tRwTNwfPxAxlqDGNPFZQB4YYW8/2GpHTFzNuMO3Gbx2rE/T7xcmMzzRCQ8HkrjV
 L7qNIsaeo5vjXZQKMYpep77XIiMz5zv2EyJgtZw+/zsqzcwnS1KdlC3kAddetMTrSO0Y
 HQMQ==
X-Gm-Message-State: ABy/qLahOXg28u81+0A+UPw0nfeRvpngSpwFMTliWFwXGyggoXO+mzCf
 BQkv6B2FwKJOmmqoh5gyyxai/AnlFSuDy1xiWrJM3NPo2wDN8vWiVzgVE2RJuIt/y/4chcdT0hR
 yt+kMDRPDVB65h+A=
X-Received: by 2002:a05:6214:410f:b0:625:aa48:e50f with SMTP id
 kc15-20020a056214410f00b00625aa48e50fmr1627359qvb.6.1688646449982; 
 Thu, 06 Jul 2023 05:27:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHuIqZlQP7W//dI+WlGjkRBAD9KiyLKJsev/r0pXvAXKtxUgsaAIJrBvu9apuUM4TVAX/CN6Q==
X-Received: by 2002:a05:6214:410f:b0:625:aa48:e50f with SMTP id
 kc15-20020a056214410f00b00625aa48e50fmr1627344qvb.6.1688646449783; 
 Thu, 06 Jul 2023 05:27:29 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g11-20020a0ce4cb000000b006365a41c354sm795806qvm.132.2023.07.06.05.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 05:27:29 -0700 (PDT)
Date: Thu, 6 Jul 2023 08:27:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/2] migration: switchover-hold parameter
Message-ID: <ZKazMNVa7nnwjneB@x1n>
References: <20230705163132.329501-1-peterx@redhat.com>
 <20230705163132.329501-2-peterx@redhat.com>
 <0ed812a4-3fb9-3bb6-6153-c1a1fc6e72d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ed812a4-3fb9-3bb6-6153-c1a1fc6e72d4@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 06, 2023 at 11:40:04AM +0300, Avihai Horon wrote:
> This only handles the QMP case, but we forgot to handle the HMP case.
> I was testing it and got the following assert:
> 
>   (qemu) migrate_set_parameter switchover-hold on
>   qemu-system-x86_64: ../migration/migration-hmp-cmds.c:627:
> hmp_migrate_set_parameter: Assertion `0' failed.
>   Aborted (core dumped)

Ouch.. I'll fix it, thanks.

-- 
Peter Xu


