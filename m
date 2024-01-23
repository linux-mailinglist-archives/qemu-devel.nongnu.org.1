Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677D838E1D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 13:05:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSFVF-00017f-1C; Tue, 23 Jan 2024 07:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSFV9-00016M-19
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 07:03:36 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSFV6-0006Iz-2t
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 07:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=czzatmFXzShaDKPDZ8zwIuNYhD6TqNlsmqbGsv2FUO4=; b=CkMNRCfN9yPkN22Ww4tjWJCNi8
 M19n9cjxaD+5E89pC+SFghd9mJqI5P/uB14OzbBeaOg3Eec3kfEqPKr/bJ/d7XLRVOJBvZh1PN1yW
 Uq0m0xizX7LWVtP0QtWK11QTKnHZHvfel5zv3YE46M4F/MSSQV3VJ7hk+ybVlYltBTp8=;
Date: Tue, 23 Jan 2024 13:03:27 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, richard.henderson@linaro.org
Subject: Re: [RFC PATCH 30/34] accel/tcg: Make tcg-all.c target indpendent
Message-ID: <a5x4m7apjbqftlvyehg35xpb2vuqt7yeytu5p43qml7wwwt3kv@wijdl5teb6be>
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-31-anjo@rev.ng>
 <b1c7e761-34ef-4143-993f-98580bffb086@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1c7e761-34ef-4143-993f-98580bffb086@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 23/01/24, Philippe Mathieu-Daudé wrote:
> Hi Anton,
> 
> On 19/1/24 15:40, Anton Johansson wrote:
> > Uses target_supports_mttcg() and target_long_bits() to turn ifdefs into
> > runtime branches.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   accel/tcg/tcg-all.c | 25 +++++++++----------------
> >   1 file changed, 9 insertions(+), 16 deletions(-)
> 
> 
> >   static void tcg_accel_instance_init(Object *obj)
> > @@ -137,17 +129,18 @@ static char *tcg_get_thread(Object *obj, Error **errp)
> >   static void tcg_set_thread(Object *obj, const char *value, Error **errp)
> >   {
> >       TCGState *s = TCG_STATE(obj);
> > +    const bool oversized_guest = target_long_bits() > TCG_TARGET_REG_BITS;
> >       if (strcmp(value, "multi") == 0) {
> > -        if (TCG_OVERSIZED_GUEST) {
> > +        if (oversized_guest) {
> >               error_setg(errp, "No MTTCG when guest word size > hosts");
> >           } else if (icount_enabled()) {
> >               error_setg(errp, "No MTTCG when icount is enabled");
> >           } else {
> > -#ifndef TARGET_SUPPORTS_MTTCG
> > -            warn_report("Guest not yet converted to MTTCG - "
> > -                        "you may get unexpected results");
> > -#endif
> > +            if (target_supports_mttcg()) {
> 
> I started smth similar but then realized this call has to be per target,
> so put my work on hold. My plan is to have a single common tcg
> accelerator framework, having target-specific code handled by vcpu
> dispatchers. Is your plan to have each target link its own tcg?

Yes I was leaning towards one tcg per target, but hadn't put much 
thought into it. I think your approach is better.  This patchset was
primarily focused on getting accl/tcg/ to compile once, with 
heterogeneous stuff coming down the line. IMO it becomes a bit easier to 
see what target-specific information we really need.

What do you think of a simple TargetConfig struct for information such 
as target_supports_mttcg() and the other functions introduced in 
cpu-target.c? We probably need dispatcher for other stuff but I think we 
can get quite far with struct.


