Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E68E27BAA48
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 21:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoU8d-0000Fl-7G; Thu, 05 Oct 2023 15:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoU8b-0000El-6w
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 15:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qoU8Z-0004Gp-Kr
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 15:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696534553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJAjkUqqJp1s7vSYtjayXapw3Wbgp8c0FIs2DwC3akw=;
 b=Aru9ocQ8sauyNQUtJn67srR1RvQ54Y0oK4wMIEKByHwixDMf4MWj/GhlRvsOV5uSIv0/k1
 7C7ocEO0q/v4Ac6ZR/L8wqjdGE5tRFrgE7/rGNj2XdLWOOgcy4BGYd/U7XoHHcD+e6YbKo
 /kmxk4zc41KcHvfVF3jvN9HnXtuOJ5Q=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-_pV13jleO6GfesCaCcOLTw-1; Thu, 05 Oct 2023 15:35:51 -0400
X-MC-Unique: _pV13jleO6GfesCaCcOLTw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1dcf04d2444so225851fac.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 12:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696534551; x=1697139351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJAjkUqqJp1s7vSYtjayXapw3Wbgp8c0FIs2DwC3akw=;
 b=ebkZHpI+DrGoIt4gZHubWns0xvXjMaL1hz6S2cFEY+X3XpS1+Gy5jimjtcHrb6SQ5g
 K+7LT1jh0i4cvVdudQeV046xYcmsanw2gs+mg6N3QPFU9RMBVzLPOxGWAT7n/ZlKKHk5
 zGLOMJitOAxsUEslVPv8MRQw8kq0RT19mH3Gjuz/qWr6ld8YaWxpcMDv5tlDPqKHrq6H
 +Cx0kabk+E6BW7/dRQNN05dCe74in+KOwhSrI1DMiN1lWoY2cyeFXBtb2+fNhhpk0o5E
 f2EKcvYbOiPUbmccRl75+ye8AGTgqQkFFk6IslpxNbO67tKMXrh+Htg9yHppxY9RS4Ai
 qnOw==
X-Gm-Message-State: AOJu0YxbJYRbciHcN5Pg2D7XmuNX2mTZg1CY1oakKPKChv9c8SXvSEBl
 ugeKyqzamYOKYod6TdXfAMJ0PTdA31WBQDqXDV6o/WcHva2zAukneSKH2JTgggrEa5EnIwQ0pO6
 Kjey4UNgW6Q+ctv8=
X-Received: by 2002:a05:6870:a98b:b0:1d0:e371:d7b0 with SMTP id
 ep11-20020a056870a98b00b001d0e371d7b0mr6288726oab.5.1696534551035; 
 Thu, 05 Oct 2023 12:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp3Ej+zYMPSNQqL58gJlKwJPixl5JV/xT3IdoiYUtwKGqNG0bNI2pW322IzTfrOWydCm6POg==
X-Received: by 2002:a05:6870:a98b:b0:1d0:e371:d7b0 with SMTP id
 ep11-20020a056870a98b00b001d0e371d7b0mr6288718oab.5.1696534550797; 
 Thu, 05 Oct 2023 12:35:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w19-20020a05620a149300b0076eee688a95sm721034qkj.0.2023.10.05.12.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 12:35:50 -0700 (PDT)
Date: Thu, 5 Oct 2023 15:35:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 03/10] migration: Refactor error handling in source
 return path
Message-ID: <ZR8QFOSPY7pqnc/W@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-4-peterx@redhat.com>
 <87il7lfcq1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il7lfcq1.fsf@suse.de>
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

On Thu, Oct 05, 2023 at 09:57:58AM -0300, Fabiano Rosas wrote:
> > @@ -2008,9 +1996,14 @@ static void *source_return_path_thread(void *opaque)
> >      }
> >  
> >  out:
> > -    if (qemu_file_get_error(rp)) {
> > +    if (err) {
> 
> Need to keep both checks here.

The next patch did that.  Let me squash that into this..

Thanks,

-- 
Peter Xu


