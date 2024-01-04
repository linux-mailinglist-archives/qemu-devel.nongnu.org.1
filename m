Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34038823B88
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:38:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFUT-0007HZ-5G; Wed, 03 Jan 2024 23:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFUQ-0007Gu-1k
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:37:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFUO-00072W-7c
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704343071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zh4oir7kaQJanjgDJQu0g7SU0yBfk0UTOoF1q7nOcc0=;
 b=KVs2GPtuELqg3JyobHJ5c5AiuY1j3aKthUfHH/H1M+lTB3JOUULge+PBIuPc6weKuQgfJy
 EYUGNjzRcA36MjU4CAqcrrTNKMEiJw7RSFHXIzX4j6B9Kn8DxAC8cmgRytMzfx9pvV6KPt
 dV7Mgb+t8w8xNdF7iXeKUQZBMbjkntg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-lnaxfj2UNQqu835fZ2f22w-1; Wed, 03 Jan 2024 23:37:49 -0500
X-MC-Unique: lnaxfj2UNQqu835fZ2f22w-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-2040e2d65ecso42473fac.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 20:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704343069; x=1704947869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zh4oir7kaQJanjgDJQu0g7SU0yBfk0UTOoF1q7nOcc0=;
 b=FdWcnenF/x05WTQuZ2oC204froUVR3XDCA5UirrrjlDg32zlOYSkfVMNNkiYXR+pvT
 WTp4Bt31Vjk8y8eHmSQAbYTLTGgfOVhybdxJ+7Phiz3/CQuNo6UK4Mfg2Q7tGqOPfMss
 5OAPyGvHIN6ZmpG6HKCYUeNiOVPc3dYOqDb3YA64/HhaC4dXwWpdbtYCc4Gr59q6R4lQ
 ee2O8upmu1S9XKtEA4A/q332m2xtzjHiGrqpIF0Sk593WUxoJKcnYPMWLO9IEFi6u8l4
 NDtx+zbvpGrwo/nnsKyXAiHJjcuAS9oSFSvudNwaID2qhKYh9A93ZZbDC2S1SNfBvyhF
 uz2w==
X-Gm-Message-State: AOJu0Yw3olcyRuntYwoZ9rhcM2YWYAbNgw6RRppMiGuCRHUmfl8jJw0i
 sw2gDfoHSp3FUBe08JMhYRk82Ja+Ozduwh7h/J2K3Tk0AVpzK1/Iv+CETf2L90qo+q/3+s8+y/2
 90fOr+uWJgilwbLAhdf2VQfw=
X-Received: by 2002:a05:6358:894:b0:174:f9ba:9482 with SMTP id
 m20-20020a056358089400b00174f9ba9482mr56693rwj.1.1704343069095; 
 Wed, 03 Jan 2024 20:37:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdYtOwitwLJWZ1kAMCmHADoiJujKq9t8pGRHKybOZu7eT8iml6L74OVKuYi28je/LHjVoa5Q==
X-Received: by 2002:a05:6358:894:b0:174:f9ba:9482 with SMTP id
 m20-20020a056358089400b00174f9ba9482mr56678rwj.1.1704343068772; 
 Wed, 03 Jan 2024 20:37:48 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 le6-20020a056a004fc600b006da0f15b31csm13006850pfb.97.2024.01.03.20.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 20:37:48 -0800 (PST)
Date: Thu, 4 Jan 2024 12:37:40 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH V9 00/12] fix migration of suspended runstate
Message-ID: <ZZY2FFq3-CGFbGPN@x1n>
References: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

On Wed, Jan 03, 2024 at 12:05:29PM -0800, Steve Sistare wrote:
> Migration of a guest in the suspended runstate is broken.  The incoming
> migration code automatically tries to wake the guest, which is wrong;
> the guest should end migration in the same runstate it started.  Further,
> after saving a snapshot in the suspended state and loading it, the vm_start
> fails.  The runstate is RUNNING, but the guest is not.
> 
> See the commit messages for the details.

I was planning to wait for an ack from Markus, but I noticed Markus will
only be back next week.  So I queued it for now, and we can work on top
just in case.

Thanks,

-- 
Peter Xu


