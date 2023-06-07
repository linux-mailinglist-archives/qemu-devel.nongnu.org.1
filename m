Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E29472654F
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vYe-00064b-BZ; Wed, 07 Jun 2023 11:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6vYV-00064F-Q4
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6vYT-0005AP-CJ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686153516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8JIJpEYxy4JXyhIoiq8p44E6g71iDkEcmSUN/qRUiI4=;
 b=JjLx8GZ3zZvHR+imCQOAaJuozrBTPl5zpSGGzTrda9rWfTrdVHTHpTmrFcvkfUBkWyIxX/
 KU13h+//iL+bvgYtWw43GmD+K4gwzy0oJolR5DW4/dzwSgbe/9WMFFVZt0bNLO5XTv5g9Z
 CLtFGakSpKTmXj48q+bg62B0fHP15X0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-mhvEA4K6OemwEPD1dct8Nw-1; Wed, 07 Jun 2023 11:58:35 -0400
X-MC-Unique: mhvEA4K6OemwEPD1dct8Nw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62615f764b4so9224066d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686153514; x=1688745514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JIJpEYxy4JXyhIoiq8p44E6g71iDkEcmSUN/qRUiI4=;
 b=VDxvqSZEOIkVBInBI0CfvOrEoNRcw7NJ1hFXayboJe2JOotu7eOF/f+cbfzRXtG1NJ
 hbuzpbWrXCAPqc2xNDMgB7Uae9tcwKsdT3WiUQhs6EKI6FMqpVhVetJeUMAIEQltAaJ/
 H41okb3jDUCUUeGsJrKYdEXKU2sL64kfRSoLOc2qggumAonXRJwDJrXBvOAhP1BIGysY
 /TWQR/vcKaq1BUr2MQmbBGZnpF0aL4NYin8hA4xl8SkXYvlqHYQsc+jM701vmQVEJTA3
 rPAaL72qUbkSNvfEYSEEIxLhfKAdy4gKYNdbjii+Bu+fUYVBfdRjzyNmWVHlzRvxepu5
 Ez/g==
X-Gm-Message-State: AC+VfDzN3xqXXVTX3WR+NdoGYz4GSvAHFZUHPJAROoekTwUyKyFo/Q1k
 61m5sDjJwIrszCwYfhrDyvn2qHaHwnKHFw13AGYiLNLnwKyMFYxRBisyu2LaDYxHMSLOTN2Y0Q7
 7jI8IqsMZrurCn9w=
X-Received: by 2002:a05:6214:1c44:b0:628:7923:b3e1 with SMTP id
 if4-20020a0562141c4400b006287923b3e1mr2724787qvb.2.1686153514685; 
 Wed, 07 Jun 2023 08:58:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4lwnI36o8jZhSWm2dsakx436Usekoh2vNba/zuARz2P/k8zLREpdWhAY2FM3fRlsc2/84+sw==
X-Received: by 2002:a05:6214:1c44:b0:628:7923:b3e1 with SMTP id
 if4-20020a0562141c4400b006287923b3e1mr2724772qvb.2.1686153514455; 
 Wed, 07 Jun 2023 08:58:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o20-20020a0cf4d4000000b00606750abaf9sm6207412qvm.136.2023.06.07.08.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:58:33 -0700 (PDT)
Date: Wed, 7 Jun 2023 11:58:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH V3] migration: simplify blockers
Message-ID: <ZICpKM2zSZSkhmTW@x1n>
References: <1686148532-249302-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1686148532-249302-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 07, 2023 at 07:35:32AM -0700, Steve Sistare wrote:
> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
> reason.  This allows migration to own the Error object, so that if
> an error occurs, migration code can free the Error and clear the client
> handle, simplifying client code.
> 
> This is also a pre-requisite for future patches that will add a mode
> argument to migration requests to support live update, and will maintain
> a list of blockers for each mode.  A blocker may apply to a single mode
> or to multiple modes, and passing Error** will allow one Error object to
> be registered for multiple modes.
> 
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


