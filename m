Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B877F7D7
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:37:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdAE-0000fY-Po; Thu, 17 Aug 2023 09:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWdAA-0000f3-Qa
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWdA8-0000WO-GY
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692279341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4aM/44Vrl979Uyh6eMPhm3FkvX+LMtZM4tW0YULQXU=;
 b=fD7/EURIXtgp2+08Lwhq9hpvDS7BV4jsR0GIdA7+/yIPrjzK5qPDGx1+GoLy/v/f2+okbB
 0Vrzkug5lDDdgeWsAOKArwCXlGLqJHchSvN23YQ8IS/JUKrVri0XlV6qPRuabOxo133Y+Y
 IRl0m33ROBzyAP7aFKeS9PFqceSJ8eM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-OZ2SRxS1OVaOKvTuA0aPVA-1; Thu, 17 Aug 2023 09:35:40 -0400
X-MC-Unique: OZ2SRxS1OVaOKvTuA0aPVA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76cb9958d60so199208485a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 06:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279340; x=1692884140;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y4aM/44Vrl979Uyh6eMPhm3FkvX+LMtZM4tW0YULQXU=;
 b=TP/WneqjTRT1Reo+ckZdfe2zeckvhozdoWurJWuxQ0lNK+sOdouosT0oo0jbDxsZgN
 Pt7/V30hOQddUqFXQ5wRo4T21dPIPXfQ/FJQkcfz9QQ5wzUKfTHQHyi6oqKCpl1mwWnz
 MjsLS5W1M9ZJZD7pqi7H5RyoCoLfKXaV42qiqDKzdwnNz0N31xN+UMoe2cdURhE9kNkj
 KvLRQp24aYSUe0YNdB7DQB4mEEnxZdofoSZn9CMTwzm2BZM9wOZOj2dFGtUWZHJGRsDP
 HeXllI8YUs2D1zyAUvrXxuPG87hV3Qn4YHL1qRe2e0T8V+KmxPygcQZg4Ly9gxbJN8Ye
 GySQ==
X-Gm-Message-State: AOJu0YwIvwXl4mTu2GwYe7XM02VFLVes898zT6DO5rlaCDn4DfwQ36A+
 hk0T/qJM/G+EXHvjF1LMA4RXiSxbBoFIxVzQPPVpevE+Y2rjS5QqRA2xCky2B7FQHHmxmQRyaZm
 g65kmv6bo9yp/CKk=
X-Received: by 2002:a05:620a:4093:b0:76c:ed4e:ac10 with SMTP id
 f19-20020a05620a409300b0076ced4eac10mr6561339qko.6.1692279339904; 
 Thu, 17 Aug 2023 06:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOdk7/FAhwYDsPBmezVegASHkxfgiqvev5f7Pg2ZeQl4Nsa0bbbrTvLSUO+XYQ00KEBk3/Zg==
X-Received: by 2002:a05:620a:4093:b0:76c:ed4e:ac10 with SMTP id
 f19-20020a05620a409300b0076ced4eac10mr6561320qko.6.1692279339606; 
 Thu, 17 Aug 2023 06:35:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a2-20020a05620a102200b007671678e325sm5168450qkk.88.2023.08.17.06.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 06:35:39 -0700 (PDT)
Date: Thu, 17 Aug 2023 09:35:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Guoyi Tu <tugy@chinatelecom.cn>
Cc: =?utf-8?B?44CQ5aSW6YOo6LSm5Y+344CR?= Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return if
 qemu file got error
Message-ID: <ZN4iKgeVeLBSCSK2@x1n>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
 <87h6p0mqk8.fsf@suse.de> <ZNv6ABLk7EjaX8dD@x1n>
 <87350klygf.fsf@suse.de> <ZNzhuF7fRUdaGthV@x1n>
 <87o7j7kohx.fsf@suse.de>
 <15874e41-fee0-49db-98fc-cf2b545fe7c2@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15874e41-fee0-49db-98fc-cf2b545fe7c2@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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

On Thu, Aug 17, 2023 at 10:19:19AM +0800, Guoyi Tu wrote:
> 
> 
> On 2023/8/16 23:15, 【外部账号】 Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Tue, Aug 15, 2023 at 07:42:24PM -0300, Fabiano Rosas wrote:
> > > > Yep, I see that. I meant explicitly move the code into the loop. Feels a
> > > > bit weird to check the QEMUFile for errors first thing inside the
> > > > function when nothing around it should have touched the QEMUFile.
> > > 
> > > Valid point.  This reminded me that now we have one indirection into
> > > ->ram_save_target_page() which is a hook now.  Putting in the caller will
> > > work for all hooks, even though they're not yet exist.
> > > 
> > > But since we don't have any other hooks yet, it'll be the same for now

Guoyi,

Your email got cut from here.  Same thing happened on emails from Hyman
(also sent from China Telecom email address), maybe your mail system did
something wrong.

-- 
Peter Xu


