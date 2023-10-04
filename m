Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F37B862C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:12:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5Pc-0001rS-0i; Wed, 04 Oct 2023 13:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo5PZ-0001qT-Gs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo5PX-0000KF-Sk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696439506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DXZGPts+3Qh2EBLPe2fWwGTEz+6NIXwgn359HZolck=;
 b=JOLhBvcmM1BrLEF4EuS0S0t+TkYPFVm62Sec9E2rhvZF52g0zlngmw+MCB2jaOqGvcylLi
 snpC79zdhDZfAn7t8f5CWiS21AP1J/8hSr2rBBvhdqhIuoeQdVDPFy+9WYeYQHY8paZnsY
 efMUnAMeYIF5KA3uKYVHunhX6mYHvHE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-jBjHSxxCPdG-reSMi1wH_Q-1; Wed, 04 Oct 2023 13:11:35 -0400
X-MC-Unique: jBjHSxxCPdG-reSMi1wH_Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65623d0075aso12136d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696439495; x=1697044295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DXZGPts+3Qh2EBLPe2fWwGTEz+6NIXwgn359HZolck=;
 b=klYJjGKM/R16nTIOJ+9/OPur1FJP70ulvAigaZTXz/FidlD3AnSdjH4KwSaY4vXp6o
 zS61w3zNXVWxYuODbluciv4D0yrtfjQNsEtyIPr+6MmuAORhhIRkopZj2HTtO8tNfvKi
 Afhr7YP1ZD4Fx9JiYphZuiW+cq0MDReFa7gq7b+2nmv5k57Hnz7WyDZGARBpIdbyO48i
 P6cXbVRu+KRuWa4VmlD9QOIe3yQCGHXbKH7602QCbuwEU19+BV7PkCnXCQ/mzZZjkH1m
 8EDJSFUEBbKK5VjehoVLovYC6zY9eVszMRye+9EMDO4RFc6S77DDQQXjIkYRcejVQa0q
 hIqQ==
X-Gm-Message-State: AOJu0YxYA81lthIXle9UtkeE7qd9EFPiI9rxsc4Bodbt2ZiZu5zJ+VYX
 M++IxNnjVfBr+iyG2aPXRaTslsj46NXRtVg4bX+f+NYMp6DrwM835kNHZVVXc2oEDRMX5rz9JXe
 Lywmn4D7FnjQl1ww=
X-Received: by 2002:a05:6214:4003:b0:65a:fc65:b235 with SMTP id
 kd3-20020a056214400300b0065afc65b235mr3036081qvb.2.1696439494824; 
 Wed, 04 Oct 2023 10:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAtma8bMwQYMNthvmK/AeC3JnDtemtn48SZEJo/eEOgdcRkHi+YmGojm5pt9jML/vbFul5Gg==
X-Received: by 2002:a05:6214:4003:b0:65a:fc65:b235 with SMTP id
 kd3-20020a056214400300b0065afc65b235mr3036060qvb.2.1696439494519; 
 Wed, 04 Oct 2023 10:11:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a11bb00b0076ef2816ff0sm1403260qkk.16.2023.10.04.10.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:11:34 -0700 (PDT)
Date: Wed, 4 Oct 2023 13:11:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 00/10] Removal of QEMUFileHooks
Message-ID: <ZR2cxboX7T5p9OyT@x1n>
References: <20231004124913.16360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004124913.16360-1-quintela@redhat.com>
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

On Wed, Oct 04, 2023 at 02:49:03PM +0200, Juan Quintela wrote:
> I remove the reviewed by from peter for 2-6 because I had to touch
> those files.

You yet didn't? :)

I saw you plan to rebase yours onto Markus's.  I'll wait for a new version.

Thanks,

-- 
Peter Xu


