Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD271EEDB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4l8G-0004Oc-Sk; Thu, 01 Jun 2023 12:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4l8D-0004NE-Us
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4l8C-0006Cc-ES
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685636791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eu+Go4JSvIlN29GYYS/ekiIT19pG/vAhiC/MaOgR+U=;
 b=KUepFc8rqhXsJsu8qbCHKkD5bLyTMz0zeYjwKfvjNTCnMdyEqchsE2aKB79eAsExP5+aTm
 wKzYoMlNwRDze/sLMS3QZU2ZDnXNFJy93EeRzZEWxdt+SY145ZEjWiJmL4ki0oMu7nrVQa
 Ocu3aLYyg9UATdMeKjU9tFCGcPNTLX4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-vSi4JcevOw2J0iRU_wIrTw-1; Thu, 01 Jun 2023 12:26:29 -0400
X-MC-Unique: vSi4JcevOw2J0iRU_wIrTw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f7d72d552fso2660961cf.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 09:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685636789; x=1688228789;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6eu+Go4JSvIlN29GYYS/ekiIT19pG/vAhiC/MaOgR+U=;
 b=S5KLGgE1O/4HS5amjYrwSpPbNs0Zt8fvtp3WZXlwePYiVS+XHr2focpQDSpvTp9VCN
 3koc5M4FZPwQhQz0MYJasXbOkyLI5fRE7fbzl0XkpRBhKTlZx9yhXWjzCAlvp6mduXOq
 kyYdM45JI5pOp6Uufz1ugvAsQm3TjBFhRxu0k5WAtWjPWJyTiEmHIL+7tvPYPWe3IomL
 MxOCNLA8kwDidDESidTOOVhMG+RTVZqeMG1XGUvkCreZLViKr8vBlAt2dDGY+oj5tEHh
 dQsDGNDA6vwOP6tWLkfmnWkjrovjZv0T+fsLeO/onh6Phc+JyHHJGWgjUS0GlXuk5pW9
 G5Gw==
X-Gm-Message-State: AC+VfDxj5zLP0+4WtnCQ9kUDCd0EamByq2KHczgeSDpXLdB2HZm76Jtd
 doBNLENTP1IGOKayc0PXrwDfFSfDWrg+DjHr1brqoFF0lWL2ruoSkXmSTeYvMuw3PJU+UROAUjj
 7JD5Qw25oNoi5uVY=
X-Received: by 2002:a05:622a:180d:b0:3f6:a8e2:127b with SMTP id
 t13-20020a05622a180d00b003f6a8e2127bmr9063090qtc.5.1685636789224; 
 Thu, 01 Jun 2023 09:26:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OR27kVMdElSHQQiLaLZM0wJHy+0zn0EX2Nor/4pVEOgVTiLeraTYlXfRp1ogajRoene2UKA==
X-Received: by 2002:a05:622a:180d:b0:3f6:a8e2:127b with SMTP id
 t13-20020a05622a180d00b003f6a8e2127bmr9063072qtc.5.1685636789009; 
 Thu, 01 Jun 2023 09:26:29 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 ch6-20020a05622a40c600b003f5352907a5sm7858001qtb.88.2023.06.01.09.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 09:26:28 -0700 (PDT)
Date: Thu, 1 Jun 2023 12:26:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, quintela@redhat.com,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
Message-ID: <ZHjGs8TeSyl22kUq@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
 <87a5xjs6ob.fsf@secure.mitica>
 <7c02b1c2-1636-24d9-8466-3bcc6c88acbd@redhat.com>
 <ZHjEh5GSgS+3i8HQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHjEh5GSgS+3i8HQ@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Thu, Jun 01, 2023 at 05:17:11PM +0100, Daniel P. Berrangé wrote:
> Could we merge this series as-is, and simply re-visit the last patch
> afterwards, once we have time to debate the feature about completion
> phase synchronization.

This sounds good to me too.

-- 
Peter Xu


