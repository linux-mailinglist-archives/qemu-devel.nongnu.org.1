Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B86B270DFAC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:52:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TLq-0002Gr-Fq; Tue, 23 May 2023 10:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1TLS-0002EH-HH
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1TLP-0001FG-8f
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684853411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2WSJOdwK2KTo8dTJHFEBQhmw8vYJ1K+BuC7ekXqbm8g=;
 b=UAwixD21n+nK/aZv9+GdyhRWPpw65Ik4lCoI/p9SvTebLHrnNurdCW3AZ4n7xRZRDLWvi0
 ycRJScHZ9feBWVSfSacJtsbTyfUZetwcMvjq/+v7b8SEwoWtjp76EFUh36EjvW4WLeusM2
 m/NMk62EpdgbQpRmuni/TCw8+lHr/n0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-fe309ynzPH-evA-knKgx0w-1; Tue, 23 May 2023 10:50:09 -0400
X-MC-Unique: fe309ynzPH-evA-knKgx0w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b1224f63aso35857185a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 07:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684853408; x=1687445408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WSJOdwK2KTo8dTJHFEBQhmw8vYJ1K+BuC7ekXqbm8g=;
 b=auNHfPgQXrC61ZcmjFah5FxAQ9wCDrG9TimqRPgX7hRM+wV+eD0li2ErQG7B3ijPqV
 XR2BCchvmsbZv1A5vC5EgHTIOj85a5OtDb8WJ56cU8628SO6qU/X/xcm85eJ6TNnZHfo
 kh4XIFm+OhndJU6s3/CPzIpZ6dsoe6NjmX2jOAeaTeFP0zzfHCcqLxi7bOvQirbKreSz
 Xn3ikL46a4TB6pfjEqTdobhwPPB+Lg5gNXEri1oYJs64GS5KskzCQA60SOytVAk/FLVd
 YcP1ahNWHrR6z/dSR6ltgMnxKfBZccJTynqYmQNkB0v2AyNXDFtz6UDoScotLb3E6co8
 pDRA==
X-Gm-Message-State: AC+VfDzXa3SIYzJhKQTWEwVY08fNONqoj4jTzc3pMC0mzcHE4NriDs52
 b1rRxC2K5ibvHaYdA0sLWMzu3blR18Pk3Jx+HDt6SRGyfWjS1OnJCuRZiEEoYCMb4R++YsJ6wuU
 LDGG8ysNNJ5jRzpU=
X-Received: by 2002:a05:620a:2108:b0:75b:23a1:1de7 with SMTP id
 l8-20020a05620a210800b0075b23a11de7mr4288611qkl.4.1684853408670; 
 Tue, 23 May 2023 07:50:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QLwssawT8oeFJMINz4vxyxRhr94/mhaliuY84jez3jcgRSjYJqN6I3jB5uUIPF0mAfFxgPQ==
X-Received: by 2002:a05:620a:2108:b0:75b:23a1:1de7 with SMTP id
 l8-20020a05620a210800b0075b23a11de7mr4288593qkl.4.1684853408360; 
 Tue, 23 May 2023 07:50:08 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 n26-20020a05620a153a00b0075785052e97sm2546359qkk.95.2023.05.23.07.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 07:50:07 -0700 (PDT)
Date: Tue, 23 May 2023 10:50:06 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>,
 "Wang, Lei4" <lei4.wang@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Message-ID: <ZGzSnr5eaS1Wsjwf@x1n>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGeWF4lzBldLLH/y@x1n> <ZGeW3R5McptUueJF@x1n>
 <DS0PR11MB63736A4AE4A624D2B9EFD19DDC7D9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGv8adigFYpLD89k@x1n>
 <DS0PR11MB63737B09D72A735EC21F3C41DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGzCYMRWa7sW9xAv@x1n>
 <DS0PR11MB637381609AFD7DA4998AB201DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB637381609AFD7DA4998AB201DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 23, 2023 at 02:30:25PM +0000, Wang, Wei W wrote:
> > It's about whether we want to protect e.g. below steps:
> > 
> > 1. start dest qemu with -incoming defer
> > 2. "migrate-set-capabilities" to enable multifd
> > 3. "migrate-incoming xxx" to setup the sockets
> > 4. "migrate-set-parameters" to setup the num of multifd   <--- will be invalid here
> 
> Yes, step 4 is invalid, but I think nobody cares about that (i.e. no place uses the
> invalid value) as step2 already fails the cap setting (with error messages).

Since only until step 3 it setups the transport_data, so step 2 should be
fine and not fail?  That's the whole point of my example or I missd
something here..

-- 
Peter Xu


