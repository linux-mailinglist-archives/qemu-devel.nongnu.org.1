Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CDF76EE23
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRaGL-0001cf-OC; Thu, 03 Aug 2023 11:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+e9d36835173043153fb4+7284+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qRaGI-0001cK-Ew
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:29:14 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+e9d36835173043153fb4+7284+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qRaGF-0001nh-FQ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=kyrl246zywEr0Cbf5D3GpYakSCSYG3Vlq30JTi/ovQs=; b=J0M8G7Y7/xDxK6VPq+NqOr6IQU
 DIzZPE13mLjY1DON/mBUTVh+fqSIOf0KyzUWLzsMPR2JSI6BpXtAei73T8pnsum/kuxuVvLBl/InX
 CGV0b1i4fX3uP0qvo9/nDB+kb09u2O2dUlI25UU0GxRuunVwMk4RkDh73zHHke+YwM1dkDE3jl+yo
 bGM1Z6uyyZPf38uTqIxEZz8pexvA0m7ppFo1bYDa5W2/mlhXKDwcSYBMN9PlWpWccfL970Cf9vCDh
 b3pijNB/XPcZbI04MOzDApYHTOyi6+UBjwoet1rSV87YzMI1ToVZ4ucgXUerOBPLHjDqioEoPMCAu
 Hj/kVt8g==;
Received: from [2001:8b0:10b:5:e396:a7b9:2ed5:7c9b]
 (helo=u3832b3a9db3152.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qRaG3-004S04-Rh; Thu, 03 Aug 2023 15:29:00 +0000
Message-ID: <2d5e23d21fdbd148d9b0d9e4c00145217c4ddd17.camel@infradead.org>
Subject: [RFC PATCH post-8.1] hw/xen: Clean up event channel 'type_val'
 handling to use union
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 03 Aug 2023 16:28:59 +0100
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-89Q7zUTq8uSM3cMUCm0D"
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+e9d36835173043153fb4+7284+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


--=-89Q7zUTq8uSM3cMUCm0D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

A previous implementation of this stuff used a 64-bit field for all of
the port information (vcpu/type/type_val) and did atomic exchanges on
them. When I implemented that in Qemu I regretted my life choices and
just kept it simple with locking instead.

So there's no need for the XenEvtchnPort to be so simplistic. We can
use a union for the pirq/virq/interdomain information, which lets us
keep a separate bit for the 'remote domain' in interdomain ports. A
single bit is enough since the only possible targets are loopback or
qemu itself.

So now we can ditch PORT_INFO_TYPEVAL_REMOTE_QEMU and the horrid
manual masking, although the in-memory representation is identical
so there's no change in the saved state ABI.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
Thought this would be a nice cleanup to avoid abusing `type_val` for
various different purposes, and especially the top bit of it for
interdomain ports. But having done it I find myself fairly ambivalent
about it. Does anyone feel strongly either way?

 hw/i386/kvm/xen_evtchn.c | 124 ++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 60 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index a731738411..446ae46022 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -58,7 +58,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(XenEvtchnState, XEN_EVTCHN)
 typedef struct XenEvtchnPort {
     uint32_t vcpu;      /* Xen/ACPI vcpu_id */
     uint16_t type;      /* EVTCHNSTAT_xxxx */
-    uint16_t type_val;  /* pirq# / virq# / remote port according to type *=
/
+    union {
+        uint16_t type_val;  /* pirq# / virq# / remote port according to ty=
pe */
+        uint16_t pirq;
+        uint16_t virq;
+        struct {
+            uint16_t port:15;
+            uint16_t to_qemu:1; /* Only two targets; qemu or loopback */
+        } interdomain;
+    } u;
 } XenEvtchnPort;
=20
 /* 32-bit compatibility definitions, also used natively in 32-bit build */
@@ -210,16 +218,16 @@ static int xen_evtchn_post_load(void *opaque, int ver=
sion_id)
         XenEvtchnPort *p =3D &s->port_table[i];
=20
         if (p->type =3D=3D EVTCHNSTAT_pirq) {
-            assert(p->type_val);
-            assert(p->type_val < s->nr_pirqs);
+            assert(p->u.pirq);
+            assert(p->u.pirq < s->nr_pirqs);
=20
             /*
              * Set the gsi to IRQ_UNBOUND; it may be changed to an actual
              * GSI# below, or to IRQ_MSI_EMU when the MSI table snooping
              * catches up with it.
              */
-            s->pirq[p->type_val].gsi =3D IRQ_UNBOUND;
-            s->pirq[p->type_val].port =3D i;
+            s->pirq[p->u.pirq].gsi =3D IRQ_UNBOUND;
+            s->pirq[p->u.pirq].port =3D i;
         }
     }
     /* Rebuild s->pirq[].gsi mapping */
@@ -243,7 +251,7 @@ static const VMStateDescription xen_evtchn_port_vmstate=
 =3D {
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32(vcpu, XenEvtchnPort),
         VMSTATE_UINT16(type, XenEvtchnPort),
-        VMSTATE_UINT16(type_val, XenEvtchnPort),
+        VMSTATE_UINT16(u.type_val, XenEvtchnPort),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -599,14 +607,13 @@ static void unbind_backend_ports(XenEvtchnState *s)
=20
     for (i =3D 1; i < s->nr_ports; i++) {
         p =3D &s->port_table[i];
-        if (p->type =3D=3D EVTCHNSTAT_interdomain &&
-            (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU)) {
-            evtchn_port_t be_port =3D p->type_val & PORT_INFO_TYPEVAL_REMO=
TE_PORT_MASK;
+        if (p->type =3D=3D EVTCHNSTAT_interdomain && p->u.interdomain.to_q=
emu) {
+            evtchn_port_t be_port =3D p->u.interdomain.port;
=20
             if (s->be_handles[be_port]) {
                 /* This part will be overwritten on the load anyway. */
                 p->type =3D EVTCHNSTAT_unbound;
-                p->type_val =3D PORT_INFO_TYPEVAL_REMOTE_QEMU;
+                p->u.interdomain.port =3D 0;
=20
                 /* Leave the backend port open and unbound too. */
                 if (kvm_xen_has_cap(EVTCHN_SEND)) {
@@ -644,7 +651,7 @@ int xen_evtchn_status_op(struct evtchn_status *status)
=20
     switch (p->type) {
     case EVTCHNSTAT_unbound:
-        if (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU) {
+        if (p->u.interdomain.to_qemu) {
             status->u.unbound.dom =3D DOMID_QEMU;
         } else {
             status->u.unbound.dom =3D xen_domid;
@@ -652,22 +659,21 @@ int xen_evtchn_status_op(struct evtchn_status *status=
)
         break;
=20
     case EVTCHNSTAT_interdomain:
-        if (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU) {
+        if (p->u.interdomain.to_qemu) {
             status->u.interdomain.dom =3D DOMID_QEMU;
         } else {
             status->u.interdomain.dom =3D xen_domid;
         }
=20
-        status->u.interdomain.port =3D p->type_val &
-            PORT_INFO_TYPEVAL_REMOTE_PORT_MASK;
+        status->u.interdomain.port =3D p->u.interdomain.port;
         break;
=20
     case EVTCHNSTAT_pirq:
-        status->u.pirq =3D p->type_val;
+        status->u.pirq =3D p->u.pirq;
         break;
=20
     case EVTCHNSTAT_virq:
-        status->u.virq =3D p->type_val;
+        status->u.virq =3D p->u.virq;
         break;
     }
=20
@@ -983,7 +989,7 @@ static int clear_port_pending(XenEvtchnState *s, evtchn=
_port_t port)
 static void free_port(XenEvtchnState *s, evtchn_port_t port)
 {
     s->port_table[port].type =3D EVTCHNSTAT_closed;
-    s->port_table[port].type_val =3D 0;
+    s->port_table[port].u.type_val =3D 0;
     s->port_table[port].vcpu =3D 0;
=20
     if (s->nr_ports =3D=3D port + 1) {
@@ -1006,7 +1012,7 @@ static int allocate_port(XenEvtchnState *s, uint32_t =
vcpu, uint16_t type,
         if (s->port_table[p].type =3D=3D EVTCHNSTAT_closed) {
             s->port_table[p].vcpu =3D vcpu;
             s->port_table[p].type =3D type;
-            s->port_table[p].type_val =3D val;
+            s->port_table[p].u.type_val =3D val;
=20
             *port =3D p;
=20
@@ -1047,15 +1053,15 @@ static int close_port(XenEvtchnState *s, evtchn_por=
t_t port,
         return -ENOENT;
=20
     case EVTCHNSTAT_pirq:
-        s->pirq[p->type_val].port =3D 0;
-        if (s->pirq[p->type_val].is_translated) {
+        s->pirq[p->u.pirq].port =3D 0;
+        if (s->pirq[p->u.pirq].is_translated) {
             *flush_kvm_routes =3D true;
         }
         break;
=20
     case EVTCHNSTAT_virq:
-        kvm_xen_set_vcpu_virq(virq_is_global(p->type_val) ? 0 : p->vcpu,
-                              p->type_val, 0);
+        kvm_xen_set_vcpu_virq(virq_is_global(p->u.virq) ? 0 : p->vcpu,
+                              p->u.virq, 0);
         break;
=20
     case EVTCHNSTAT_ipi:
@@ -1065,8 +1071,8 @@ static int close_port(XenEvtchnState *s, evtchn_port_=
t port,
         break;
=20
     case EVTCHNSTAT_interdomain:
-        if (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU) {
-            uint16_t be_port =3D p->type_val & ~PORT_INFO_TYPEVAL_REMOTE_Q=
EMU;
+        if (p->u.interdomain.to_qemu) {
+            uint16_t be_port =3D p->u.interdomain.port;
             struct xenevtchn_handle *xc =3D s->be_handles[be_port];
             if (xc) {
                 if (kvm_xen_has_cap(EVTCHN_SEND)) {
@@ -1076,14 +1082,15 @@ static int close_port(XenEvtchnState *s, evtchn_por=
t_t port,
             }
         } else {
             /* Loopback interdomain */
-            XenEvtchnPort *rp =3D &s->port_table[p->type_val];
-            if (!valid_port(p->type_val) || rp->type_val !=3D port ||
+            XenEvtchnPort *rp =3D &s->port_table[p->u.interdomain.port];
+            if (!valid_port(p->u.interdomain.port) ||
+                rp->u.interdomain.port !=3D port ||
                 rp->type !=3D EVTCHNSTAT_interdomain) {
                 error_report("Inconsistent state for interdomain unbind");
             } else {
                 /* Set the other end back to unbound */
                 rp->type =3D EVTCHNSTAT_unbound;
-                rp->type_val =3D 0;
+                rp->u.interdomain.port =3D 0;
             }
         }
         break;
@@ -1207,7 +1214,7 @@ int xen_evtchn_bind_vcpu_op(struct evtchn_bind_vcpu *=
vcpu)
     if (p->type =3D=3D EVTCHNSTAT_interdomain ||
         p->type =3D=3D EVTCHNSTAT_unbound ||
         p->type =3D=3D EVTCHNSTAT_pirq ||
-        (p->type =3D=3D EVTCHNSTAT_virq && virq_is_global(p->type_val))) {
+        (p->type =3D=3D EVTCHNSTAT_virq && virq_is_global(p->u.virq))) {
         /*
          * unmask_port() with do_unmask=3D=3Dfalse will just raise the eve=
nt
          * on the new vCPU if the port was already pending.
@@ -1352,19 +1359,15 @@ int xen_evtchn_bind_ipi_op(struct evtchn_bind_ipi *=
ipi)
 int xen_evtchn_bind_interdomain_op(struct evtchn_bind_interdomain *interdo=
main)
 {
     XenEvtchnState *s =3D xen_evtchn_singleton;
-    uint16_t type_val;
     int ret;
=20
     if (!s) {
         return -ENOTSUP;
     }
=20
-    if (interdomain->remote_dom =3D=3D DOMID_QEMU) {
-        type_val =3D PORT_INFO_TYPEVAL_REMOTE_QEMU;
-    } else if (interdomain->remote_dom =3D=3D DOMID_SELF ||
-               interdomain->remote_dom =3D=3D xen_domid) {
-        type_val =3D 0;
-    } else {
+    if (interdomain->remote_dom !=3D DOMID_QEMU &&
+        interdomain->remote_dom !=3D DOMID_SELF &&
+        interdomain->remote_dom !=3D xen_domid) {
         return -ESRCH;
     }
=20
@@ -1375,8 +1378,8 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind=
_interdomain *interdomain)
     qemu_mutex_lock(&s->port_lock);
=20
     /* The newly allocated port starts out as unbound */
-    ret =3D allocate_port(s, 0, EVTCHNSTAT_unbound, type_val,
-                        &interdomain->local_port);
+    ret =3D allocate_port(s, 0, EVTCHNSTAT_unbound, 0, &interdomain->local=
_port);
+
     if (ret) {
         goto out;
     }
@@ -1401,7 +1404,8 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind=
_interdomain *interdomain)
             assign_kernel_eventfd(lp->type, xc->guest_port, xc->fd);
         }
         lp->type =3D EVTCHNSTAT_interdomain;
-        lp->type_val =3D PORT_INFO_TYPEVAL_REMOTE_QEMU | interdomain->remo=
te_port;
+        lp->u.interdomain.to_qemu =3D 1;
+        lp->u.interdomain.port =3D interdomain->remote_port;
         ret =3D 0;
     } else {
         /* Loopback */
@@ -1415,13 +1419,13 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bi=
nd_interdomain *interdomain)
          * the port that was just allocated for the local end.
          */
         if (interdomain->local_port !=3D interdomain->remote_port &&
-            rp->type =3D=3D EVTCHNSTAT_unbound && rp->type_val =3D=3D 0) {
+            rp->type =3D=3D EVTCHNSTAT_unbound && !rp->u.interdomain.to_qe=
mu) {
=20
             rp->type =3D EVTCHNSTAT_interdomain;
-            rp->type_val =3D interdomain->local_port;
+            rp->u.interdomain.port =3D interdomain->local_port;
=20
             lp->type =3D EVTCHNSTAT_interdomain;
-            lp->type_val =3D interdomain->remote_port;
+            lp->u.interdomain.port =3D interdomain->remote_port;
         } else {
             ret =3D -EINVAL;
         }
@@ -1440,7 +1444,6 @@ int xen_evtchn_bind_interdomain_op(struct evtchn_bind=
_interdomain *interdomain)
 int xen_evtchn_alloc_unbound_op(struct evtchn_alloc_unbound *alloc)
 {
     XenEvtchnState *s =3D xen_evtchn_singleton;
-    uint16_t type_val;
     int ret;
=20
     if (!s) {
@@ -1451,18 +1454,19 @@ int xen_evtchn_alloc_unbound_op(struct evtchn_alloc=
_unbound *alloc)
         return -ESRCH;
     }
=20
-    if (alloc->remote_dom =3D=3D DOMID_QEMU) {
-        type_val =3D PORT_INFO_TYPEVAL_REMOTE_QEMU;
-    } else if (alloc->remote_dom =3D=3D DOMID_SELF ||
-               alloc->remote_dom =3D=3D xen_domid) {
-        type_val =3D 0;
-    } else {
+    if (alloc->remote_dom !=3D DOMID_QEMU && alloc->remote_dom !=3D DOMID_=
SELF &&
+        alloc->remote_dom !=3D xen_domid) {
         return -EPERM;
     }
=20
     qemu_mutex_lock(&s->port_lock);
=20
-    ret =3D allocate_port(s, 0, EVTCHNSTAT_unbound, type_val, &alloc->port=
);
+    ret =3D allocate_port(s, 0, EVTCHNSTAT_unbound, 0, &alloc->port);
+
+    if (!ret && alloc->remote_dom =3D=3D DOMID_QEMU) {
+        XenEvtchnPort *p =3D &s->port_table[alloc->port];
+        p->u.interdomain.to_qemu =3D 1;
+    }
=20
     qemu_mutex_unlock(&s->port_lock);
=20
@@ -1489,12 +1493,12 @@ int xen_evtchn_send_op(struct evtchn_send *send)
=20
     switch (p->type) {
     case EVTCHNSTAT_interdomain:
-        if (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU) {
+        if (p->u.interdomain.to_qemu) {
             /*
              * This is an event from the guest to qemu itself, which is
              * serving as the driver domain.
              */
-            uint16_t be_port =3D p->type_val & ~PORT_INFO_TYPEVAL_REMOTE_Q=
EMU;
+            uint16_t be_port =3D p->u.interdomain.port;
             struct xenevtchn_handle *xc =3D s->be_handles[be_port];
             if (xc) {
                 eventfd_write(xc->fd, 1);
@@ -1504,7 +1508,7 @@ int xen_evtchn_send_op(struct evtchn_send *send)
             }
         } else {
             /* Loopback interdomain ports; just a complex IPI */
-            set_port_pending(s, p->type_val);
+            set_port_pending(s, p->u.interdomain.port);
         }
         break;
=20
@@ -1546,8 +1550,7 @@ int xen_evtchn_set_port(uint16_t port)
=20
     /* QEMU has no business sending to anything but these */
     if (p->type =3D=3D EVTCHNSTAT_virq ||
-        (p->type =3D=3D EVTCHNSTAT_interdomain &&
-         (p->type_val & PORT_INFO_TYPEVAL_REMOTE_QEMU))) {
+        (p->type =3D=3D EVTCHNSTAT_interdomain && p->u.interdomain.to_qemu=
)) {
         set_port_pending(s, port);
         ret =3D 0;
     }
@@ -2057,7 +2060,7 @@ int xen_be_evtchn_bind_interdomain(struct xenevtchn_h=
andle *xc, uint32_t domid,
     switch (gp->type) {
     case EVTCHNSTAT_interdomain:
         /* Allow rebinding after migration, preserve port # if possible */
-        be_port =3D gp->type_val & ~PORT_INFO_TYPEVAL_REMOTE_QEMU;
+        be_port =3D gp->u.interdomain.port;
         assert(be_port !=3D 0);
         if (!s->be_handles[be_port]) {
             s->be_handles[be_port] =3D xc;
@@ -2078,7 +2081,8 @@ int xen_be_evtchn_bind_interdomain(struct xenevtchn_h=
andle *xc, uint32_t domid,
         }
=20
         gp->type =3D EVTCHNSTAT_interdomain;
-        gp->type_val =3D be_port | PORT_INFO_TYPEVAL_REMOTE_QEMU;
+        gp->u.interdomain.to_qemu =3D 1;
+        gp->u.interdomain.port =3D be_port;
         xc->guest_port =3D guest_port;
         if (kvm_xen_has_cap(EVTCHN_SEND)) {
             assign_kernel_eventfd(gp->type, guest_port, xc->fd);
@@ -2123,7 +2127,7 @@ int xen_be_evtchn_unbind(struct xenevtchn_handle *xc,=
 evtchn_port_t port)
         /* This should never *not* be true */
         if (gp->type =3D=3D EVTCHNSTAT_interdomain) {
             gp->type =3D EVTCHNSTAT_unbound;
-            gp->type_val =3D PORT_INFO_TYPEVAL_REMOTE_QEMU;
+            gp->u.interdomain.port =3D 0;
         }
=20
         if (kvm_xen_has_cap(EVTCHN_SEND)) {
@@ -2277,11 +2281,11 @@ EvtchnInfoList *qmp_xen_event_list(Error **errp)
=20
         info->type =3D p->type;
         if (p->type =3D=3D EVTCHNSTAT_interdomain) {
-            info->remote_domain =3D g_strdup((p->type_val & PORT_INFO_TYPE=
VAL_REMOTE_QEMU) ?
+            info->remote_domain =3D g_strdup(p->u.interdomain.to_qemu ?
                                            "qemu" : "loopback");
-            info->target =3D p->type_val & PORT_INFO_TYPEVAL_REMOTE_PORT_M=
ASK;
+            info->target =3D p->u.interdomain.port;
         } else {
-            info->target =3D p->type_val;
+            info->target =3D p->u.type_val; /* pirq# or virq# */
         }
         info->vcpu =3D p->vcpu;
         info->pending =3D test_bit(i, pending);
--=20
2.34.1



--=-89Q7zUTq8uSM3cMUCm0D
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwODAzMTUyODU5WjAvBgkqhkiG9w0BCQQxIgQgx4hRrJpF
OySG3r6jaxPFcB8MDZLGHpLm3U2CdYxR7mAwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCIK8J7oBRa1TBFU2IjlerBjof1ghEJtkCm
NFj0Q6mPWVlAZuNo2RQe3MWR8+whwp5Qmf6unJQ2D4Dx0GSnLPejZHtAJQjpfIkWlsRcNzvXa0b7
mon/zidQl8LtC8SiUvHkrIUHd21LOoIejQZoqxc1H2g02A+bbV4KmpH+ymM5TkJqP9fSKc6nb3vm
tG3GVp/DzWG3y5JaMPtWPa/6HnVutV+HTqBjYRlXBj2nAk3/o6R5+xBTledJ8KKvUF86IAhC4+rC
5taVfvruS+3uU+i40JieMjrsVqIxeJT/gcGwYZeq/91+Xhi4e6S/i5uYPThajB+xoY7gdPN2VXSV
QWwgvte1R8yV3Zch1JrfGVQJixdopT3jxZOpoSCTITPnksY2XT7KbYPylKUQ9QFfxZK9jMJOQvWu
ErXjC8AZpZPGCxljYbBgP6ACLO6HLuXIqQqIOlyAdqy6NAl+8kpJsNB7CorwqL4J0VLvhdMtsENH
WwinfDq39drTLckbdEBkvH62MGDqlabrC0XhUGmB4jHhz779roFvMd0lQt2tXTxba+d5kHo5cSHm
Z72gtbKTxfYEFaobLC9vwh4hDPbyy8+G54SIhQ4T9eHkTOBxLHABfzRTlw/RAps2bR2L/PKwbG6k
fPjTEjQf+yFbJcldVghf7S49fIULHDHjZYS6SdouNAAAAAAAAA==


--=-89Q7zUTq8uSM3cMUCm0D--

