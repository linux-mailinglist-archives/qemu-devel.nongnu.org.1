Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6257D8486
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 16:22:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw1EH-0001Zp-IX; Thu, 26 Oct 2023 10:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw1EC-0001ZX-Q4
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 10:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw1E7-00077w-53
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 10:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698330045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ka98h2gd5F+DNMJ4LfRkh78Q1sBIMpzJv6cliWgrMOQ=;
 b=YSfJ2BEBhv4N40Nu8unExJxkRcJ6nYsppKvWcduQ2XTRLv+R1G7VDc/kw/Ja+PMiWfjLwi
 THKdqJErOSxyxdOE7fJBQRmAIaMiqR4xQU3dAWLSj+bq1Q/nRN3KWUPJtKIDfjAAVMxjMX
 O9lEE5l7MeXqYUvFoDp1LnfDKB64ogU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-BLuqhvdvPX-qbN9LCovjig-1; Thu, 26 Oct 2023 10:20:43 -0400
X-MC-Unique: BLuqhvdvPX-qbN9LCovjig-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41e1899175eso2503781cf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 07:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698330043; x=1698934843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ka98h2gd5F+DNMJ4LfRkh78Q1sBIMpzJv6cliWgrMOQ=;
 b=MXoLMWbJHfxJyoc/Wh/peJlyJW82TjBDbodD7EhvsmZjlsVbgQE+qmpmBTJ05qrPkQ
 Kty/ZMxTdXVo1YyywJRfIfv3tp4kl37bCy7S1rpZFhDNRxEkD+1XRy7hYxKJaz/ynbxU
 IhXTTPlUmhZvGuIrWOidOMabVvNEJbRdEv4/Getnis97wYYCPhmfDiysAwd7u2gd8+D1
 zAwUJrURa/fVbdTPgRaN7riJeFN9pxfKPuTbI3NRj5LzQ8se6fOMcU4m3zPRYAg5pflb
 FXFkyGGoQ3pw4KLvfTZ93AqNOJZ8Snce7HKdpkDeQzTxzYHM5bylX7pw/WEEyMnc9MlX
 jIRw==
X-Gm-Message-State: AOJu0Yy1tBhgCcqPsqCoktQafy890rSVr+u5YipdxuRQLjHJx9etQgnG
 JqwixS8pDXizRSHp2d1G9mvsEQ62jHxPG+3KiodBWBqeHQQQh24aoZ/5LrZrUvr/zZ5j6qCE8yV
 NROngHuEgNstfyh8=
X-Received: by 2002:a05:622a:1997:b0:41c:c83d:f82a with SMTP id
 u23-20020a05622a199700b0041cc83df82amr21875818qtc.3.1698330043063; 
 Thu, 26 Oct 2023 07:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7iW8pCkFDOYM1FV55DACEl/k47+40/iHg2TN69C9c1yD1Zucor97tXWHzjLzx0KhG2O+iXw==
X-Received: by 2002:a05:622a:1997:b0:41c:c83d:f82a with SMTP id
 u23-20020a05622a199700b0041cc83df82amr21875796qtc.3.1698330042702; 
 Thu, 26 Oct 2023 07:20:42 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l10-20020ac848ca000000b004108d49f391sm5027195qtr.48.2023.10.26.07.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 07:20:42 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:20:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/6] system/physmem: IOMMU: Invoke the translate_size
 function if it is implemented
Message-ID: <ZTp1uWQ8c/t6BCBW@x1n>
References: <20231025051430.493079-1-ethan84@andestech.com>
 <20231025051430.493079-3-ethan84@andestech.com>
 <ZTkw4itrYANXm4qR@x1n> <ZToLrlSX56GkeQQW@ethan84-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZToLrlSX56GkeQQW@ethan84-VirtualBox>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 26, 2023 at 02:48:14PM +0800, Ethan Chen wrote:
> My target is to support IOPMP partially hit error. IOPMP checks whole memory 
> access region is in the same entry. If not, reject the access instead of modify
> the access size.

Could you elaborate why is that important?  In what use case?

Consider IOVA mapped for address range iova=[0, 4K] only, here we have a
DMA request with range=[0, 8K].  Now my understanding is what you want to
achieve is don't trigger the DMA to [0, 4K] and fail the whole [0, 8K]
request.

Can we just fail at the latter DMA [4K, 8K] when it happens?  After all,
IIUC a device can split the 0-8K DMA into two smaller DMAs, then the 1st
chunk can succeed then if it falls in 0-4K.  Some further explanation of
the failure use case could be helpful.

Thanks,

-- 
Peter Xu


