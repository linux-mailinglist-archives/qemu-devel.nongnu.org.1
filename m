Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 483FA9DB4D9
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Nov 2024 10:35:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGavF-0003za-NJ; Thu, 28 Nov 2024 04:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tGavE-0003zE-0S
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 04:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tGavC-0006lm-E1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 04:34:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732786487;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6NZO8CGrZwWB1q5DRND68K5dRvVRtYZmeJ70aP3Oalo=;
 b=OXY9LhxnQbmeOm+otBW/h7hvYPl//pGQ+VGmtTmB1/gQekhBf7B9idt3B9vRDa5Ysp1m3J
 osGyHr6F5jQB1olVFqLxUNqw36MCn3mE2+u7T6wqzNYR0ChW7IsR0n2YylYJbOiKmaHEda
 FZG1cFkQquittkb/2UbcQsc6xo3Y5o8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-IK9eNkS0MOuXYZ_aq74_ig-1; Thu,
 28 Nov 2024 04:34:43 -0500
X-MC-Unique: IK9eNkS0MOuXYZ_aq74_ig-1
X-Mimecast-MFC-AGG-ID: IK9eNkS0MOuXYZ_aq74_ig
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADA4819560A2; Thu, 28 Nov 2024 09:34:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69F141956046; Thu, 28 Nov 2024 09:34:38 +0000 (UTC)
Date: Thu, 28 Nov 2024 09:34:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
Message-ID: <Z0g5Kz77xeevUmb4@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
 <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
 <Z0bhDbpovFOkDomB@redhat.com>
 <07f2dcf3-8796-4e8e-af1e-c3e860dcd095@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07f2dcf3-8796-4e8e-af1e-c3e860dcd095@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 27, 2024 at 10:31:13AM -0800, Pierrick Bouvier wrote:
> On 11/27/24 01:06, Daniel P. Berrangé wrote:
> > On Tue, Nov 26, 2024 at 04:54:18PM -0600, Richard Henderson wrote:
> > > On 11/26/24 11:52, Thomas Huth wrote:
> > > > I think we want to continue to maek failing downloads as test failures,
> > > > otherwise we'll never notice when an asset is not available from the
> > > > internet anymore (since SKIPs just get ignored).
> > > 
> > > I disagree.  Download failures are not rare.
> > 
> > Failures of the test to download assets will be rare *if* we have the
> > CI runner cache fixed. We only need to successfully download each
> > asset once, and it should be cached forever with no expiry timeout.
> > 
> > So we have an initially bootstrapping problem once caching is fixed,
> > where download failures could impact us. Once the cache is primed,
> > we'll only be at risk of download failures when introducing new
> > asset URLs, so I think it is fair to say failures should be rare
> > *if* we get the caching fixed.
> > 
> > With regards,
> > Daniel
> 
> Beyond the QEMU CI, we should think about users trying to run tests, and
> having the same kind of problems, but without having access to the magic
> cache.
> 
> Regarding the assets download, why don't we mirror them somewhere reliable
> instead of relying on third party storage?

If QEMU hosts these files, then QEMU is liable for license compliance,
IOW, we have to identify & potentially host the full & corresponding
source for all binaries in the images. This is not a business we want
to be involved in as a project.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


